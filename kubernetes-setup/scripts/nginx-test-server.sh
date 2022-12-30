#!/bin/bash

# the below commands will deploy a basic nginx server with two replicas
## use <control-plane-ip>:<port> in order to see if you can access this locally; see 'node-config.sh' to get ip for 'k8s-master'
kubectl create deployment nginx --image=nginx
kubectl get deployment
kubectl scale deployment/nginx --replicas=2
kubectl get pod -o wide
kubectl expose deployment nginx --type=NodePort --port=80
kubectl get svc