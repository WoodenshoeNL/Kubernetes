#Create Resource Group
az group create -n kubernetes -l westeurope

#Create vNet
az network vnet create -g kubernetes \
  -n kubernetes-vnet \
  --address-prefix 10.240.0.0/24 \
  --subnet-name kubernetes-subnet

#Create NSG
az network nsg create -g kubernetes -n kubernetes-nsg

#Attache NSG to Subnet
az network vnet subnet update -g kubernetes \
  -n kubernetes-subnet \
  --vnet-name kubernetes-vnet \
  --network-security-group kubernetes-nsg

#Create SSH NSG rule
az network nsg rule create -g kubernetes \
  -n kubernetes-allow-ssh \
  --access allow \
  --destination-address-prefix '*' \
  --destination-port-range 22 \
  --direction inbound \
  --nsg-name kubernetes-nsg \
  --protocol tcp \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --priority 1000

#Create Kubernetes-Api NSG rule
az network nsg rule create -g kubernetes \
  -n kubernetes-allow-api-server \
  --access allow \
  --destination-address-prefix '*' \
  --destination-port-range 6443 \
  --direction inbound \
  --nsg-name kubernetes-nsg \
  --protocol tcp \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --priority 1001

#ist NSG rules
az network nsg rule list -g kubernetes --nsg-name kubernetes-nsg --query "[].{Name:name, \
  Direction:direction, Priority:priority, Port:destinationPortRange}" -o table

#Create Public Load Balancer for Kubernetes
az network lb create -g kubernetes \
  -n kubernetes-lb \
  --backend-pool-name kubernetes-lb-pool \
  --public-ip-address kubernetes-pip \
  --public-ip-address-allocation static

#Show Public IP Load Balancer
az network public-ip  list --query="[?name=='kubernetes-pip'].{ResourceGroup:resourceGroup, \
  Region:location,Allocation:publicIpAllocationMethod,IP:ipAddress}" -o table
