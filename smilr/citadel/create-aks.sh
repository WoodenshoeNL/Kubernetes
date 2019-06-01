
az provider register -n Microsoft.Network
az provider register -n Microsoft.Storage
az provider register -n Microsoft.Compute
az provider register -n Microsoft.ContainerService


group='kubernetes'
region='westeurope'

az group create -n $group -l $region

az aks create -g $group -n aks-cluster -l $region \
--node-count 1 --node-vm-size Standard_DS2_v2 \
--kubernetes-version 1.12.8 --verbose


sudo az aks install-cli

az aks get-credentials -g $group -n aks-cluster

kubectl cluster-info
kubectl get nodes
kubectl get all -n kube-system
