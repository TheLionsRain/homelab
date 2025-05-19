deployment_subscription_id    = "2b22d58f-b265-48e2-8341-e0f2afc6610c"
location                      = "northeurope"
key_vault_resource_group_name = "rg-homelab-helheim-kv-ne"
key_vault_name                = "kv-homelab-helheim-ne"
key_vault_sku                 = "standard"
key_vault_secrets = {
  "cloudflare-api-token" = "#{CLOUDFLARE_API_TOKEN}#"
}