# Intro

This is a demo repo for performing webinars and demos for Infrastructure as code (on Azure platform). Find below deployment instructions

## Deployment

Deploy kubernetes cluster via Terraform. Stand in the repo root directory

```bash
pushd tf
terraform apply -auto-approve
terraform output kube_config > ../KUBECONFIG
popd
```

Deploy a wordpress application (app + DB tiers) via yaml files

```bash
export KUBECONFIG=$PWD/KUBECONFIG
kubectl get node
helm init
helm install stable/wordpress -f k8s/values.yaml
```