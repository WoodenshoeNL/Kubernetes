#!/bin/bash

location="westeurope"
ResourceGroup="WoodKube"

ACR_NAME="woodregistry"

#Create ACR

az acr create \
    --name $ACR_NAME \
    --resource-group $ResourceGroup \
    --location $location \
    --sku Standard \
    --admin-enabled true


#Print ACR password

az acr credential show \
    --name $ACR_NAME \
    --resource-group $ResourceGroup \
    --query "passwords[0].value" \
    --output tsv
