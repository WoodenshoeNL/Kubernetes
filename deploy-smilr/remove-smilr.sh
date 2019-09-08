#!/bin/bash


kubectl delete -f data-api.deploy.yaml
kubectl delete -f mongo.svc.yaml
kubectl delete -f data-api.svc.yaml
kubectl delete -f frontend.svc.yaml
kubectl delete -f frontend.deploy.yaml
kubectl delete -f mongo.PersistentVolume.yaml
kubectl delete -f mongo.stateful.yaml
