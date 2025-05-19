# Current
data "azurerm_client_config" "current" {}

# New Resources
## Resource Group
resource "azurerm_resource_group" "rg_kv" {
  name     = var.key_vault_resource_group_name
  location = var.location
}

## Key Vault
resource "azurerm_key_vault" "kv" {
  name                      = var.key_vault_name
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg_kv.name
  sku_name                  = var.key_vault_sku
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  enable_rbac_authorization = true
  purge_protection_enabled  = var.key_vault_purge_protection
}

## Role Assignments
resource "azurerm_role_assignment" "roles" {
  for_each             = { for role in var.key_vault_role_assignments : "${role.principal_id}-${role.role_definition_name}" => role }
  scope                = azurerm_key_vault.kv.id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}

## Secrets
resource "azurerm_key_vault_secret" "secrets" {
  for_each     = nonsensitive(var.key_vault_secrets)
  name         = each.key
  value        = var.key_vault_secrets[each.key]
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    azurerm_role_assignment.roles
  ]
}