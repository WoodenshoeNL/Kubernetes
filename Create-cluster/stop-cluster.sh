#!/bin/bash


ResourceGroup="WoodKube"

NODE="kubemaster01"
az vm deallocate \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait


NODE="kubenode01"
az vm deallocate \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait


NODE="kubenode02"
az vm deallocate \
    --resource-group $ResourceGroup \
    --name $NODE \
    --no-wait
