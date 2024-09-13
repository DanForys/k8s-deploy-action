# k8s-deploy-action

A GitHub action to apply Kubernetes templates with [ytt](https://carvel.dev/ytt/) templating.

## Usage

Example action file:

```yaml
name: Deploy Kubernetes Resources

on:
  release:
    types: [published]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Update Deployment
        uses: DanForys/k8s-deploy-action@v2
        env:
          # Add your base64-encoded kube config to a GitHub action or environment secret
          KUBE_CONFIG_DATA: ${{ secrets.KUBE_CONFIG_DATA }}
        with:
          # Directory with the ytt/k8s yaml files to be applied
          template_dir: infra/my-infra-folder
          # Optional deployment name to await rollout
          await_rollout_for_deployment: my-deployment-name
          # Optional inline string YAML file of values to be used by ytt
          template_values: |
            docker_image: danforys/theanimator:pr${{ github.event.pull_request.number}}-${{ steps.shashort.outputs.sha_short }}
```
