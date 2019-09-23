#!/bin/bash


ResourceGroup="MC_WoodAKS_WoodKube_westeurope"

NODE="aks-agentpool-34104423-0"
az vm deallocate \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait


NODE="aks-agentpool-34104423-1"
az vm deallocate \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait


NODE="aks-agentpool-34104423-2"
az vm deallocate \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait
