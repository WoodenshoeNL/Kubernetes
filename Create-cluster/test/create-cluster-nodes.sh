#! /bin/bash

az vm availability-set create -g kubernetes -n node-as

UBUNTULTS="Canonical:UbuntuServer:18.04-LTS:18.04.201905140"

for i in 0 1 2; do
    echo "[Node ${i}] Creating public IP..."
    az network public-ip create -n node-${i}-pip -g kubernetes > /dev/null

    echo "[Node ${i}] Creating NIC..."
    az network nic create -g kubernetes \
        -n node-${i}-nic \
        --private-ip-address 10.240.0.1${i} \
        --public-ip-address node-${i}-pip \
        --vnet kubernetes-vnet \
        --subnet kubernetes-subnet \
        --ip-forwarding \
        --lb-name kubernetes-lb \
        --lb-address-pools kubernetes-lb-pool > /dev/null

    echo "[Node ${i}] Creating VM..."
    az vm create -g kubernetes \
        -n node-${i} \
        --image ${UBUNTULTS} \
        --generate-ssh-keys \
        --nics node-${i}-nic \
        --availability-set node-as \
        --nsg '' \
        --admin-username 'kuberoot' > /dev/null
done
