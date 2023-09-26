#!/bin/bash -xe
# https://learn.microsoft.com/ja-jp/azure/openshift/tutorial-delete-cluster
CLUSTER=dinoue
RESOURCEGROUP=dinoue-aro

az login
az aro delete --resource-group $RESOURCEGROUP --name $CLUSTER

