#!/bin/bash

location="westeurope"
ResourceGroup="WoodKube"
vNet="Kube-Vnet"
subNet="Kube-Subnet"

node1="kubenode01"
pipName="woodKube-lb-pip"
pipDns="wood-kube-lb"

lbName="woodKube-lb"
frontlbName="woodKube-lb-front"
backlbName="woodKube-lb-back"
probeLbName="woodKube-lb-probe"
frontendRule="woodKube-lb-rule-frontend"
probeLbName2="woodKube-lb-probe2"
frontendRule2="woodKube-lb-rule-Data"


#Create Loadbalancer PIP

az network public-ip create \
    --name $pipName \
    --resource-group $ResourceGroup \
    --allocation-method Dynamic \
    --dns-name $pipDns \
    --sku Basic \
    --version IPv4



#Create Loadbalancer

az network lb create \
    --resource-group $ResourceGroup \
    --name $lbName \
    --public-ip-address $pipName \
    --frontend-ip-name $frontlbName \
    --backend-pool-name $backlbName


#Create Loadbalancer Probe

az network lb probe create \
    --resource-group $ResourceGroup \
    --lb-name $lbName \
    --name $probeLbName \
    --protocol tcp \
    --port 30001

az network lb probe create \
    --resource-group $ResourceGroup \
    --lb-name $lbName \
    --name $probeLbName2 \
    --protocol tcp \
    --port 30000


#Create Loadbalancer RuleS

az network lb rule create \
    --resource-group $ResourceGroup \
    --lb-name $lbName \
    --name $frontendRule \
    --protocol tcp \
    --frontend-port 80 \
    --backend-port 30001 \
    --frontend-ip-name $frontlbName \
    --backend-pool-name $backlbName \
    --probe-name $probeLbName

az network lb rule create \
    --resource-group $ResourceGroup \
    --lb-name $lbName \
    --name $frontendRule2 \
    --protocol tcp \
    --frontend-port 8080 \
    --backend-port 30000 \
    --frontend-ip-name $frontlbName \
    --backend-pool-name $backlbName \
    --probe-name $probeLbName2



##Create Nic ipconfigs

#az network nic ip-config create \
#    --resource-group $ResourceGroup \
#    --name Node1NicConfig \
#    --nic-name Node1Nic

#az network nic ip-config create \
#    --resource-group $ResourceGroup \
#    --name Node2NicConfig \
#    --nic-name Node2Nic


#Add nodes to Loadbalancer

az network nic ip-config address-pool add \
    --resource-group $ResourceGroup \
    --lb-name $lbName \
    --address-pool $backlbName \
    --ip-config-name ipconfig1 \
    --nic-name Node1Nic

#az network nic ip-config address-pool add \
#    --resource-group $ResourceGroup \
#    --lb-name $lbName \
#    --address-pool $backlbName \
#     --ip-config-name Node2NicConfig \
#    --nic-name Node2Nic


