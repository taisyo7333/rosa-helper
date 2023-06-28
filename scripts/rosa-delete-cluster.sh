#!/bin/bash -xe
# https://docs.openshift.com/rosa/rosa_install_access_delete_clusters/rosa_getting_started_iam/rosa-deleting-cluster.html

CLUSTER_NAME=dinoue
CLUSTER_ID=$(rosa describe cluster -c="${CLUSTER_NAME}" -o json | jq .id | tr -d '"')

# Enter the following command to delete a cluster and watch the logs, replacing <cluster_name> with the name or ID of your cluster:
rosa delete cluster --cluster="${CLUSTER_NAME}" --yes --watch

rosa delete operator-roles --cluster $CLUSTER_ID --mode auto --yes
rosa delete oidc-provider --cluster $CLUSTER_ID --mode auto  --yes

# To clean up your CloudFormation stack, enter the following command:
# rosa init --delete

# I: Logged in as '<xxx>' on 'https://api.openshift.com'
# I: Validating AWS credentials...
# I: AWS credentials are valid!
# ? Are you sure you want to delete cluster administrator user 'osdCcsAdmin'? Yes
# I: Deleting cluster administrator user 'osdCcsAdmin'...
# E: Failed to delete 'osdCcsAdmin': User still has clusters