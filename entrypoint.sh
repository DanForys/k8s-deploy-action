#!/bin/sh -l

echo ${KUBE_CONFIG_DATA} | base64 -d > kubeconfig
export KUBECONFIG=kubeconfig

echo ::echo::on
env

echo $INPUT_DEPLOYMENT


# status=$?
# echo ::set-output name=result::$result
# echo "$result"
# if [[ $status -eq 0 ]]; then exit 0; else exit 1; fi