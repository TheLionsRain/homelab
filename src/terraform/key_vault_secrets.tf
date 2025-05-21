# Secrets from variables
resource "azurerm_key_vault_secret" "external_secrets" {
  for_each     = nonsensitive(var.key_vault_secrets)
  name         = each.key
  value        = var.key_vault_secrets[each.key]
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_role_assignment.roles_kv
  ]
}

# Secrets from resources
## Storage Account - Backup
resource "azurerm_key_vault_secret" "st_backup_name_secret" {
  name = var.st_backup_name_secret_name
  value = azurerm_storage_account.st_backup.name
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "st_backup_access_key_secret" {
  name = var.st_backup_access_key_secret_name
  value = azurerm_storage_account.st_backup.primary_access_key
  key_vault_id = azurerm_key_vault.kv.id
}
