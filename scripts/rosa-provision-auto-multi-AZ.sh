#!/bin/bash -x
set -e 

# --------
# -- Objective --
# Provisioning ROSA cluster
# auto motde (STS , Public)
# --------

CLUSTER_NAME="dinoue"

# if Existing the above cluster , do not proccedd, stop here with error status

# Prerequisite
aws iam set-security-token-service-preferences --global-endpoint-token-version v2Token

# Provisioning ROSA
rosa version

rosa create account-roles --mode auto --yes

rosa create cluster --mode auto --cluster-name "${CLUSTER_NAME}" --multi-az --sts--yes

# 
rosa describe cluster -c "${CLUSTER_NAME}"

# watch
rosa logs install -c "${CLUSTER_NAME}" --watch

# rosa create admin --cluster="${CLUSTER_NAME}"