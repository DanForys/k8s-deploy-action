#!/bin/bash

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

echo ::echo::on
echo ${INPUT_TEMPLATE_VALUES} > template_values.yaml

ytt -f ${INPUT_TEMPLATE_DIR} --data-values-file ./template_values.yaml

# kubectl set image deployment/${INPUT_DEPLOYMENT} ${INPUT_CONTAINER_NAME}=${INPUT_IMAGE}
# deployStatus=$?
# if [[ $deployStatus -ne 0 ]]; then exit 1; fi

# kubectl rollout status deployment/${INPUT_DEPLOYMENT}
# rolloutStatus=$?
# exit $rolloutStatus