deployment_subscription_id    = "2b22d58f-b265-48e2-8341-e0f2afc6610c"
location                      = "northeurope"
key_vault_resource_group_name = "rg-homelab-helheim-kv-ne"
key_vault_name                = "kv-homelab-helheim-ne"
key_vault_sku                 = "standard"
key_vault_role_assignments = [
  {
    role_definition_name = "Key Vault Administrator"
    principal_id         = "a176ebb0-c01d-473a-8205-2370942a9e9e" # sp-gh-homelab
  },
  {
    role_definition_name = "Key Vault Secrets User"
    principal_id         = "27274c88-7182-4afa-8bac-b7e7db0ba915" # app-k8s-helheim-external-secrets-ne
  }
]
key_vault_secrets = {
  "cloudflare-api-token" = "#{CLOUDFLARE_API_TOKEN}#"
}