#!/bin/bash

location="westeurope"
ResourceGroup="WoodKube"

ACR_NAME="woodregistry"

#Create Data API

az acr build \
    --registry $ACR_NAME \
    --resource-group $ResourceGroup \
    --file node/data-api/Dockerfile \
    --image smilr/data-api https://github.com/benc-uk/smilr.git


#Create Frontend

az acr build \
    --registry $ACR_NAME \
    --resource-group $ResourceGroup \
    --file node/frontend/Dockerfile \
    --image smilr/frontend https://github.com/benc-uk/smilr.git

#show Images

az acr repository list \
    --resource-group $ResourceGroup \
    --name $ACR_NAME \
    --output table
