#!/bin/bash

kubectl delete -f ./config/data-api.deploy.yaml
kubectl delete -f ./config/data-api.svc.yaml
kubectl delete -f ./config/frontend.deploy.yaml
kubectl delete -f ./config/frontend.svc.yaml
kubectl delete -f ./config/mongo.deploy.yaml
kubectl delete -f ./config/mongo.svc.yaml
kubectl delete -f ./config/mongo.stateful.yaml
