NODE="node-0"
PUBLIC_IP_ADDRESS=$(az network public-ip show -g kubernetes \
  -n ${NODE}-pip --query "ipAddress" -otsv)

ssh michel@${PUBLIC_IP_ADDRESS}


NODE="node-1"
PUBLIC_IP_ADDRESS=$(az network public-ip show -g kubernetes \
  -n ${NODE}-pip --query "ipAddress" -otsv)

ssh michel@${PUBLIC_IP_ADDRESS}


NODE="node-2"
PUBLIC_IP_ADDRESS=$(az network public-ip show -g kubernetes \
  -n ${NODE}-pip --query "ipAddress" -otsv)

ssh michel@${PUBLIC_IP_ADDRESS}
