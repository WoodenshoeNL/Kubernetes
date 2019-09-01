#!/bin/bash

ACR_NAME="woodregistry"
mongoIp="192.168.1.2"

cat > ./mongo.deploy.yaml << EOL
kind: Deployment
apiVersion: apps/v1
metadata:
  name: mongodb
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mongodb
  template:
    metadata:
      labels:
        app: mongodb
    spec:
      containers:
      - name: mongodb-pod
        image: mongo:3.4-jessie
        ports:
        - containerPort: 27017
EOL


kubectl apply -f mongo.deploy.yaml

cat > ./data-api.deploy.yaml << EOL
kind: Deployment
apiVersion: apps/v1
metadata:
  name: data-api
spec:
  replicas: 1
  selector:
    matchLabels:
      app: data-api
  template:
    metadata:
      labels:
        app: data-api
    spec:
      containers:
      - name: data-api-pod
        image: $ACR_NAME.azurecr.io/smilr/data-api
        ports:
        - containerPort: 4000
        env:
        - name: MONGO_CONNSTR
          value: mongodb://$mongoIp
      imagePullSecrets:
      - name: acr-auth
EOL

kubectl apply -f data-api.deploy.yaml

