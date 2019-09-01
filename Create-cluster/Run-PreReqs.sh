#!/bin/bash

ResourceGroup="WoodKube"

NODE="Master"
PUBLIC_IP_ADDRESS=$(az network public-ip show \
    --resource-group $ResourceGroup \
    -n ${NODE}Pip \
    --query "ipAddress" -otsv)

ssh michel@${PUBLIC_IP_ADDRESS} < ./install-preReq.sh

NODE="Node1"
PUBLIC_IP_ADDRESS=$(az network public-ip show \
    --resource-group $ResourceGroup \
    -n ${NODE}Pip \
    --query "ipAddress" -otsv)

ssh michel@${PUBLIC_IP_ADDRESS} < ./install-preReq.sh

NODE="Node2"
PUBLIC_IP_ADDRESS=$(az network public-ip show \
    --resource-group $ResourceGroup \
    -n ${NODE}Pip \
    --query "ipAddress" -otsv)

ssh michel@${PUBLIC_IP_ADDRESS} < ./install-preReq.sh
