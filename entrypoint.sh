#!/bin/bash

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

echo ::echo::on
echo -e "${INPUT_TEMPLATE_VALUES}" > template_values.yaml

cat ./template_values.yaml

if [[ $INPUT_DELETE ]]; then
  ytt -f ${INPUT_TEMPLATE_DIR} --data-values-file ./template_values.yaml | kubectl delete -f -
  exit $?
fi

ytt -f ${INPUT_TEMPLATE_DIR} --data-values-file ./template_values.yaml | kubectl apply -f -
deployStatus=$?
if [[ $deployStatus -ne 0 ]]; then exit 1; fi

if [[ -v $INPUT_AWAIT_ROLLOUT_FOR_DEPLOYMENT ]]; then
  kubectl rollout status deployment/${INPUT_AWAIT_ROLLOUT_FOR_DEPLOYMENT}
  rolloutStatus=$?
  exit $rolloutStatus
fi
