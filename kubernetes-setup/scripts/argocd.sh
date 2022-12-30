#!/bin/bash

# install argocd
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# create service and get details
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
kubectl get svc -n argocd

# get password for 'admin' account -- can be changes later to something like 'argoAdmin123$'
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

# cli
curl -sSL -o argocd-linux-arm64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-arm64
sudo install -m 555 argocd-linux-arm64 /usr/local/bin/argocd
rm argocd-linux-arm64

# login with argocd login <server>
# can follow 'getting started' here: https://argo-cd.readthedocs.io/en/stable/getting_started/ -- app deployment works but some or all example apps will fail due to arm64 arch