#!/bin/bash -xe

CLUSTER=dinoue
RESOURCEGROUP=dinoue-aro

az login

az aro list-credentials \
  --name $CLUSTER \
  --resource-group $RESOURCEGROUP

# api endpoint
az aro show -g dinoue-aro -n dinoue --query apiserverProfile.url -o tsv

az aro show \
    --name $CLUSTER \
    --resource-group $RESOURCEGROUP \
    --query "consoleProfile.url" -o tsvapiServer=$(az aro show -g $RESOURCEGROUP -n $CLUSTER --query apiserverProfile.url -o tsv)