# ArgoCD

## Manual Installation
```yaml
helm install argocd argocd/argo-cd \
  --version ^7.0.0 \
  --namespace argocd \
  --create-namespace \
  --set configs.params."server\.insecure"=true
```