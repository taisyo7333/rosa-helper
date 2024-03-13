#!/bin/bash -ex

CLUSTER_NAME=${1:?}
CLUSTER_VERSION=${2:?}
AWS_REGION="ap-northeast-1"

rosa version

#rosa create account-roles --mode auto --yes

#rosa verify quota  --region="${CLUSTER_REGION}"
#rosa verify oc

#rosa create oidc-config --mode=auto

#OIDC_CONFIG_ID="24euuacgb8d8gc8jbbs19tl026p4uiah"
SUBNET_IDS="subnet-0da2b570b2e1322a1,subnet-05375caf93ae2f95a,subnet-083e5c469b9e13747"

rosa create cluster \
  --operator-roles-prefix "${CLUSTER_NAME}" \
  --sts  \
  --private-link \
  --multi-az  \
  --region "${AWS_REGION}" \
  --version "${CLUSTER_VERSION}" \
  --cluster-name "${CLUSTER_NAME}" \
  --subnet-ids "${SUBNET_IDS}"

# 
rosa describe cluster -c "${CLUSTER_NAME}"
``

rosa create operator-roles --cluster  "${CLUSTER_NAME}" -m auto --yes
rosa create oidc-provider --cluster  "${CLUSTER_NAME}" -m auto --yes
# watch
rosa logs install -c "${CLUSTER_NAME}" --watch

rosa create admin --cluster="${CLUSTER_NAME}"

rosa version