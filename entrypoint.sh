#!/bin/bash

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

echo ::echo::on
kubectl set image deployment/${INPUT_DEPLOYMENT} ${INPUT_CONTAINER-NAME}=${INPUT_IMAGE}
deployStatus=$?
if [[ $deployStatus -ne 0 ]]; then exit 1; fi

kubectl rollout status deployment/${INPUT_DEPLOYMENT}
rolloutStatus=$?
exit $rolloutStatus