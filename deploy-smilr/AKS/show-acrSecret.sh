#!/bin/bash

location="westeurope"
ResourceGroup="WoodKube"

ACR_NAME="woodregistry"



#Print ACR password

az acr credential show \
    --name $ACR_NAME \
    --resource-group $ResourceGroup \
    --query "passwords[0].value" \
    --output tsv
