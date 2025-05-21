# New Resources
## Resource Group
resource "azurerm_resource_group" "rg_st" {
  name     = var.storage_account_resource_group_name
  location = var.location
}

## Storage Account
resource "azurerm_storage_account" "st_backup" {
  name                     = var.backup_storage_account_name
  resource_group_name      = azurerm_resource_group.rg_st.name
  location                 = azurerm_resource_group.rg_st.location
  account_kind             = var.backup_storage_account_kind
  account_tier             = var.backup_storage_account_tier
  account_replication_type = var.backup_storage_account_replication_type
}

## Role Assignments
resource "azurerm_role_assignment" "roles_st_backup" {
  for_each             = { for role in var.backup_storage_account_role_assignments : "${role.principal_id}-${role.role_definition_name}" => role }
  scope                = azurerm_storage_account.st_backup.id
  role_definition_name = each.value.role_definition_name
  principal_id         = each.value.principal_id
}

## Longhorn Container
resource "azurerm_storage_container" "container_longhorn" {
  name               = var.longhorn_container_name
  storage_account_id = azurerm_storage_account.st_backup.id
  depends_on = [
    azurerm_role_assignment.roles_st_backup
  ]
}
