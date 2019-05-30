#https://azurecitadel.com/cloud-native/kubernetes

ACR_NAME='woodacr'
group='kubernetes'

ACR_PWD=`az acr credential show -n $ACR_NAME -g $group --query "passwords[0].value" -o tsv`

kubectl create secret docker-registry acr-auth --docker-server $ACR_NAME.azurecr.io --docker-username $ACR_NAME --docker-password $ACR_PWD --docker-email ignore@dummy.com
