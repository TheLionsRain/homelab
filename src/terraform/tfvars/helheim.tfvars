deployment_subscription_id    = "2b22d58f-b265-48e2-8341-e0f2afc6610c"
location                      = "northeurope"
key_vault_resource_group_name = "rg-homelab-helheim-kv-ne"
key_vault_name                = "kv-homelab-helheim-ne"
key_vault_sku                 = "standard"
key_vault_role_assignments = [
  {
    role_definition_name = "Key Vault Administrator"
    principal_id         = "372dc01a-ddc4-4de0-b37d-472ffe31e28b" # sp-gh-homelab
  },
  {
    role_definition_name = "Key Vault Secrets User"
    principal_id         = "09efc1fe-6ac9-4ada-8eb8-7d9d3c758c1c" # app-k8s-helheim-external-secrets-ne
  }
]
key_vault_secrets = {
  "cloudflare-api-token" = "#{CLOUDFLARE_API_TOKEN}#"
}