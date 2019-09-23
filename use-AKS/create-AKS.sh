#!/bin/bash

ResourceGroup="WoodAKS"
AKSCluster="WoodKube"

az aks create \
    --resource-group $ResourceGroup \
    --name $AKSCluster \
    --node-count 3 \
    --enable-addons monitoring \
    --generate-ssh-keys \
    --service-principal <appId> \
    --client-secret <password>
