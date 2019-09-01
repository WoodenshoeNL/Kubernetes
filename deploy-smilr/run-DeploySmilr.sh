#!/bin/bash

ResourceGroup="WoodKube"

NODE="Master"
PUBLIC_IP_ADDRESS=$(az network public-ip show \
    --resource-group $ResourceGroup \
    -n ${NODE}Pip \
    --query "ipAddress" -otsv)

ssh michel@${PUBLIC_IP_ADDRESS} < ./deploy-smilr.sh
