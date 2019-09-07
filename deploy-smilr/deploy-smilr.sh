#!/bin/bash

ACR_NAME="woodregistry"
#mongoIp="192.168.1.2"


#Deploy Mongodb Deployment

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


#Deploy Data-api Deployment

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
          value: mongodb://mongodb-svc.default
      imagePullSecrets:
      - name: acr-auth
EOL

kubectl apply -f data-api.deploy.yaml


#Deploy Mongodb Service

cat > ./mongo.svc.yaml << EOL
kind: Service
apiVersion: v1
metadata:
  name: mongodb-svc
spec:
  type: ClusterIP
  ports:
  - protocol: TCP
    port: 27017
    targetPort: 27017
  selector:
    app: mongodb
EOL

kubectl apply -f mongo.svc.yaml


#Deploy data-api Service

cat > ./data-api.svc.yaml << EOL
kind: Service
apiVersion: v1
metadata:
  name: data-api-svc
spec:
  type: NodePort
  ports:
  - protocol: TCP
    port: 80
    targetPort: 4000
    nodePort: 30000
  selector:
    app: data-api
EOL

kubectl apply -f data-api.svc.yaml


#Deploy Frondend Service

cat > ./frontend.svc.yaml << EOL
kind: Service
apiVersion: v1
metadata:
  name: frontend-svc
spec:
  type: LoadBalancer
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
    nodePort: 30001
  selector:
    app: frontend
EOL

kubectl apply -f frontend.svc.yaml


#Deploy Frontend Deployment

cat > ./frontend.deploy.yaml << EOL
kind: Deployment
apiVersion: apps/v1
metadata:
  name: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
    spec:
      containers:
      - name: frontend-pod
        image: $ACR_NAME.azurecr.io/smilr/frontend
        ports:
        - containerPort: 3000
        env:
        - name: API_ENDPOINT
          value: http://wood-kube-lb.westeurope.cloudapp.azure.com:8080/api
      imagePullSecrets:
      - name: acr-auth
EOL

kubectl apply -f frontend.deploy.yaml


#Create Mongodb statefull

cat > ./mongo.stateful.yaml << EOL
kind: StatefulSet
apiVersion: apps/v1
metadata:
  name: mongodb
spec:
  serviceName: mongodb
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
        volumeMounts:
          - name: mongo-vol
            mountPath: /data/db
  volumeClaimTemplates:
    - metadata:
        name: mongo-vol
      spec:
        accessModes: [ "ReadWriteOnce" ]
        storageClassName: default
        resources:
          requests:
            storage: 500M
EOL

