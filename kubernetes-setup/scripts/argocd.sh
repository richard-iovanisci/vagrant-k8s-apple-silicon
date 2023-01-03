#!/bin/bash

# install argocd
## note, this can also be done using helm
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# create service and get details
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'
kubectl get svc -n argocd

# get password for 'admin' account -- can be changes later to something like 'argoAdmin123$'
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

# cli
curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

# login with argocd login <server>
# can follow 'getting started' here: https://argo-cd.readthedocs.io/en/stable/getting_started/
## for amd64, need to edit deployment for argocd-repo-server:
### kubectl rollout restart deployment/argocd-repo-server -n argocd
### remove: seccompProfile:/ type: RuntimeDefault from containerSecurityContext
### kubectl rollout restart deployment/argocd-repo-server -n argocd
