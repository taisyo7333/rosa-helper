#!/bin/bash -x
# https://docs.openshift.com/rosa/rosa_install_access_delete_clusters/rosa_getting_started_iam/rosa-deleting-cluster.html
set -e

CLUSTER_NAME=dinoue

# Enter the following command to delete a cluster and watch the logs, replacing <cluster_name> with the name or ID of your cluster:
rosa delete cluster --cluster="${CLUSTER_NAME}" --watch

# To clean up your CloudFormation stack, enter the following command:
rosa init --delete