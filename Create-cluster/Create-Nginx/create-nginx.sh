#!/bin/bash

location="westeurope"
ResourceGroup="WoodKube"


az vm create \
    --resource-group $ResourceGroup \
    --name nginx-gw \
    --image UbuntuLTS \
    --admin-username michel \
    --generate-ssh-keys \
    --custom-data cloud-init.txt
