#!/bin/bash -ex

CLUSTER_NAME="dinoue"
CLUSTER_VERSION="4.13.1"
AWS_REGION="us-east-1"

rosa version

#rosa create account-roles --mode auto --yes

#rosa verify quota  --region="${CLUSTER_REGION}"
#rosa verify oc

#rosa create oidc-config --mode=auto

OIDC_CONFIG_ID="24euuacgb8d8gc8jbbs19tl026p4uiah"
SUBNET_ID="subnet-02607dd91c34feedd"

rosa create cluster \
  --oidc-config-id "${OIDC_CONFIG_ID}" \
  --operator-roles-prefix "${CLUSTER_NAME}" \
  --sts  \
  --private-link \
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