
ACR_NAME='woodacr'
group='kubernetes'
github='https://github.com/WoodenshoeNL/smilr.git'

az acr build --registry $ACR_NAME -g $group --file node/data-api/Dockerfile --image smilr/data-api $github
