#!/bin/bash


ResourceGroup="MC_WoodAKS_WoodKube_westeurope"

#Start Nodes

NODE="aks-agentpool-34104423-0"
az vm start \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait


NODE="aks-agentpool-34104423-1"
az vm start \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait


NODE="aks-agentpool-34104423-2"
az vm start \
    --resource-group $ResourceGroup \
    --name $NODE \


#Show IP Master

NODE="aks-agentpool-34104423-0"
az network public-ip show \
    --resource-group $ResourceGroup \
    --name ${NODE}Pip \
    --query "ipAddress" -otsv
