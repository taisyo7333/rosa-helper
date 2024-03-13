#!/bin/bash -xe

CLUSTER_NAME=${1:?Must provide cluster name for you}
CLUSTER_VERSION=${2:?Must provide OCP version such as 4.13.8}
CLUSTER_REGION="ap-northeast-1"
#CLUSTER_REGION="ap-southeast-2"

# --region us-east-1 -
# if Existing the above cluster , do not proccedd, stop here with error status

# Prerequisite
aws iam set-security-token-service-preferences --global-endpoint-token-version v2Token

# Provisioning ROSA
rosa version

rosa login

# verify
# it's for non-sts
# rosa verify permissions --region="${CLUSTER_REGION}"
rosa verify quota  --region="${CLUSTER_REGION}"
rosa verify oc
rosa init

rosa create account-roles --mode auto --yes

rosa create cluster \
  --mode auto \
  --cluster-name "${CLUSTER_NAME}" \
  --sts  \
  --region="${CLUSTER_REGION}" \
  --multi-az \
  --version="${CLUSTER_VERSION}" \
  --yes

# --fips \
#
rosa describe cluster -c "${CLUSTER_NAME}"

# watch
rosa logs install -c "${CLUSTER_NAME}" --watch

# create cluster-admin user
rosa create admin --cluster="${CLUSTER_NAME}"

# testing purpose: Running the network verification manually using the CLI
# rosa verify network -c "${CLUSTER_NAME}"