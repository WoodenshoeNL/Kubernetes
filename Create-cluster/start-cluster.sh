#!/bin/bash


ResourceGroup="WoodKube"

#Start Nodes

NODE="kubemaster01"
az vm start \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait


NODE="kubenode01"
az vm start \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait


NODE="kubenode02"
az vm start \
    --resource-group $ResourceGroup \
    --name $NODE \


#Show IP Master

NODE="Master"
az network public-ip show \
    --resource-group $ResourceGroup \
    --name ${NODE}Pip \
    --query "ipAddress" -otsv
