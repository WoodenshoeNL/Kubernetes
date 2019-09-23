#!/bin/bash

ResourceGroup="WoodAKS"
AKSCluster="WoodKube"

sudo brew update && brew upgrade azure-cli

sudo az aks install-cli

az aks get-credentials --resource-group $ResourceGroup --name $AKSCluster
