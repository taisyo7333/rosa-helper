#!/bin/bash -xe
CLUSTER_NAME="dinoue"
CLUSTER_REGION="ap-northeast-2"

# if Existing the above cluster , do not proccedd, stop here with error status

# Prerequisite
aws iam set-security-token-service-preferences --global-endpoint-token-version v2Token

# Provisioning ROSA
rosa version

# verify
# it's for non-sts
# rosa verify permissions --region="${CLUSTER_REGION}"
rosa verify quota  --region="${CLUSTER_REGION}"
rosa verify oc

# rosa login
#rosa login --token="${ROSA_TOKEN}" --region="${CLUSTER_REGION}"

rosa create account-roles --mode auto --yes

rosa create cluster \
  --mode auto \
  --cluster-name "${CLUSTER_NAME}" \
  --sts  \
  --region="${CLUSTER_REGION}" \
  --yes

# --multi-az
# --fips \

#
rosa describe cluster -c "${CLUSTER_NAME}"

# watch
rosa logs install -c "${CLUSTER_NAME}" --watch

rosa create admin --cluster="${CLUSTER_NAME}"
