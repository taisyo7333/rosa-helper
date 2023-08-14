#!/bin/bash -ex

CLUSTER_NAME=${1:?}
CLUSTER_VERSION="4.13.4"
AWS_REGION="us-east-2"

rosa version

#rosa create account-roles --mode auto --yes

#rosa verify quota  --region="${CLUSTER_REGION}"
#rosa verify oc

#rosa create oidc-config --mode=auto

OIDC_CONFIG_ID="24oltqpvkn4tq0djvj0vq4tdos96cr79"
SUBNET_ID="subnet-057ef0d8fcbaccbd9,subnet-06762fb0b818bf7b9"

rosa create cluster \
  --oidc-config-id "${OIDC_CONFIG_ID}" \
  --operator-roles-prefix "${CLUSTER_NAME}" \
  --sts  \
  --region "${AWS_REGION}" \
  --version "${CLUSTER_VERSION}" \
  --cluster-name "${CLUSTER_NAME}" \
  --subnet-ids "${SUBNET_ID}"

# 
rosa describe cluster -c "${CLUSTER_NAME}"
``
# watch
rosa logs install -c "${CLUSTER_NAME}" --watch

rosa create admin --cluster="${CLUSTER_NAME}"

rosa version