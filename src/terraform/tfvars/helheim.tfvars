# General Variables
deployment_subscription_id    = "2b22d58f-b265-48e2-8341-e0f2afc6610c"
location                      = "northeurope"

# Key Vault Variables
## Key Vault Resource Group
key_vault_resource_group_name = "rg-homelab-helheim-kv-ne"

## Key Vault
key_vault_name                = "kv-homelab-helheim-ne"
key_vault_sku                 = "standard"

## Key Vault Role Assignments
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

## Key Vault Secrets
key_vault_secrets = {
  "cloudflare-api-token" = "#{CLOUDFLARE_API_TOKEN}#",
  "authentik-crypto-key" = "#{AUTHENTIK_CRYPTO_KEY}"
}

# Storage Account Variables
## Storage Account Resource Group
storage_account_resource_group_name = "rg-homelab-helheim-storage-ne"

## Storage Account - Backup
backup_storage_account_name = "sthomelabhelheimbackupne"
backup_storage_account_kind = "BlobStorage"
backup_storage_account_tier = "Standard"
backup_storage_account_replication_type = "LRS"

## Storage Account - Backup - Role Assignments
backup_storage_account_role_assignments = [
  {
    role_definition_name = "Storage Account Contributor"
    principal_id         = "a176ebb0-c01d-473a-8205-2370942a9e9e" # sp-gh-homelab
  },
  {
    role_definition_name = "Storage Blob Data Contributor"
    principal_id         = "616f3b54-c44f-4758-bc09-96a8247cb324" # app-k8s-helheim-longhorn-ne
  }
]

## Storage Account - Backup - Longhorn Container
longhorn_container_name = "c-backup"