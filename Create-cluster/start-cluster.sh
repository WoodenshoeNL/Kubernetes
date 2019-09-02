#!/bin/bash


ResourceGroup="WoodKube"

NODE="kubemaster01"
az vm start \
    --resource-group $ResourceGroup \
    --name $NODE


NODE="kubenode01"
az vm start \
    --resource-group $ResourceGroup \
    --name $NODE


NODE="kubenode02"
az vm start \
    --resource-group $ResourceGroup \
    --name $NODE
