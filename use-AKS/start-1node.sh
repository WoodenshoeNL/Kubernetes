#!/bin/bash


ResourceGroup="MC_WoodAKS_WoodKube_westeurope"

#Start Nodes

NODE="aks-agentpool-34104423-0"
az vm start \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait

