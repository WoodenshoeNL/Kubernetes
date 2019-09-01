#!/bin/bash

location="westeurope"
ResourceGroup="WoodKube"
vNet="Kube-Vnet"
subNet="Kube-Subnet"
vNetRange="10.11.0.0/16"
subNetRange="10.11.0.0/24"


#Create Resource Group

az group create --name $ResourceGroup --location $location


#Create VNet

az network vnet create \
    --resource-group $ResourceGroup \
    --name $vNet \
    --address-prefix $vNetRange \
    --subnet-name $subNet \
    --subnet-prefix $subNetRange


#Create NIC's

az network nic create \
    --resource-group $ResourceGroup \
    --vnet-name $vNet \
    --subnet $subNet \
    -n MasterNic

az network nic create \
    --resource-group $ResourceGroup \
    --vnet-name $vNet \
    --subnet $subNet \
    -n Node1Nic

az network nic create \
    --resource-group $ResourceGroup \
    --vnet-name $vNet \
    --subnet $subNet \
    -n Node2Nic


#Create NSG
az network nsg create \
    --resource-group $ResourceGroup \
    -n kubernetes-nsg

#Attache NSG to Subnet
az network vnet subnet update \
    --resource-group $ResourceGroup \
    -n kubernetes-subnet \
    --vnet-name kubernetes-vnet \
    --network-security-group kubernetes-nsg

#Create SSH NSG rule
az network nsg rule create \
    --resource-group $ResourceGroup \
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



#Create Master Node:

az vm create \
    --resource-group $ResourceGroup \
    --name kubemaster01 \
    --image UbuntuLTS \
    --admin-username michel \
    --generate-ssh-keys \
    --size Standard_A2 \
    --nics MasterNic




