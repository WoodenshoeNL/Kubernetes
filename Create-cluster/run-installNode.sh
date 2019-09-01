#!/bin/bash

ResourceGroup="WoodKube"

NODE="Node1"
PUBLIC_IP_ADDRESS=$(az network public-ip show \
    --resource-group $ResourceGroup \
    -n ${NODE}Pip \
    --query "ipAddress" -otsv)

ssh michel@${PUBLIC_IP_ADDRESS} < ./install-Node.sh

NODE="Node2"
PUBLIC_IP_ADDRESS=$(az network public-ip show \
    --resource-group $ResourceGroup \
    -n ${NODE}Pip \
    --query "ipAddress" -otsv)

ssh michel@${PUBLIC_IP_ADDRESS} < ./install-Node.sh


