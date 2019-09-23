#!/bin/bash

location="westeurope"
ResourceGroup="WoodKube"

ACR_NAME="woodregistry"

ACR_PWD="nothing"


kubectl create secret docker-registry acr-auth \
    --docker-server $ACR_NAME.azurecr.io \
    --docker-username $ACR_NAME \
    --docker-password $ACR_PWD \
    --docker-email ignore@dummy.com
