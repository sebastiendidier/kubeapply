#!/bin/bash

set -e

# Required versions

# From Achille, "If we use a different version than v3.5.4 the content of
# eks-configuration ends up being reformatted, which will trigger a recreation
# of the Zookeeper cluster for Centrifuge's Kafka in production."
HELM_VERSION="3.5.4"
# Checksums are e.g. here: https://github.com/helm/helm/releases/tag/v3.5.4
HELM_SHA256_SUM="a8ddb4e30435b5fd45308ecce5eaad676d64a5de9c89660b56face3fe990b318"

IAM_AUTHENTICATOR_VERSION="0.5.2"
IAM_AUTHENTICATOR_SHA256_SUM="5bbe44ad7f6dd87a02e0b463a2aed9611836eb2f40d7fbe8c517460a4385621b"

KUBECTL_VERSION="v1.20.2"
KUBECTL_SHA512_SUM="e4513cdd65ed980d493259cc7eaa63c415f97516db2ea45fa8c743a6e413a0cdaf299d03dd799286cf322182bf9694204884bb0dd0037cf44592ddfa5e51f183"

KIND_VERSION="v0.8.1"
KIND_SHA_256_SUM="781c3db479b805d161b7c2c7a31896d1a504b583ebfcce8fcd49538c684d96bc"

GOOS=linux
GOARCH=amd64

echo "Downloading helm at version ${HELM_VERSION}"
wget -q https://get.helm.sh/helm-v${HELM_VERSION}-${GOOS}-${GOARCH}.tar.gz
echo "${HELM_SHA256_SUM} helm-v${HELM_VERSION}-${GOOS}-${GOARCH}.tar.gz" | sha256sum -c
tar -xzf helm-v${HELM_VERSION}-${GOOS}-${GOARCH}.tar.gz
cp ${GOOS}-${GOARCH}/helm .

echo "Downloading aws-iam-authenticator at version ${IAM_AUTHENTICATOR_VERSION}"
wget -q -O aws-iam-authenticator https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${IAM_AUTHENTICATOR_VERSION}/aws-iam-authenticator_${IAM_AUTHENTICATOR_VERSION}_${GOOS}_${GOARCH}
echo "${IAM_AUTHENTICATOR_SHA256_SUM} aws-iam-authenticator" | sha256sum -c
chmod +x aws-iam-authenticator

echo "Downloading kubectl at version ${KUBECTL_VERSION}"
wget -q https://dl.k8s.io/${KUBECTL_VERSION}/kubernetes-client-${GOOS}-${GOARCH}.tar.gz
echo "${KUBECTL_SHA512_SUM} kubernetes-client-${GOOS}-${GOARCH}.tar.gz" | sha512sum -c
tar -xvzf kubernetes-client-${GOOS}-${GOARCH}.tar.gz
cp kubernetes/client/bin/kubectl .

echo "Downloading kind at version ${KIND_VERSION}"
wget -q -O kind https://kind.sigs.k8s.io/dl/${KIND_VERSION}/kind-${GOOS}-${GOARCH}
echo "${KIND_SHA_256_SUM} kind" | sha256sum -c
chmod +x kind
