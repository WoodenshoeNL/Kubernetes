#!/bin/bash


ResourceGroup="WoodKube"

NODE="kubemaster01"
az vm stop \
    --resource-group $ResourceGroup \
    --name $NODE


NODE="kubenode01"
az vm stop \
    --resource-group $ResourceGroup \
    --name $NODE


NODE="kubenode02"
az vm stop \
    --resource-group $ResourceGroup \
    --name $NODE
