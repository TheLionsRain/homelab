# General Variables
variable "deployment_subscription_id" {
  description = "The ID of the subscription where the resources will be deployed."
  type        = string
}

variable "location" {
  description = "The Azure region where the resources will be deployed."
  type        = string
}

# Key Vault Variables
## Key Vault Resource Group
variable "key_vault_resource_group_name" {
  description = "The name of the resource group where the Key Vault will be created."
  type        = string
}

## Key Vault
variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "key_vault_sku" {
  description = "The SKU of the Key Vault."
  type        = string

  validation {
    condition     = contains(["standard", "premium"], lower(var.key_vault_sku))
    error_message = "The Key Vault SKU must be either 'standard' or 'premium'."
  }
}

variable "key_vault_purge_protection" {
  description = "Enable purge protection for the Key Vault. Defaults to false."
  type        = bool
  default     = false
}

## Key Vault Role Assignments
variable "key_vault_role_assignments" {
  description = "A list of role assignments for the Key Vault. Defaults to an empty list."
  type = list(object({
    role_definition_name = string
    principal_id         = string
  }))
  default = []
}

## Key Vault Secrets
variable "key_vault_secrets" {
  description = "A map of secrets to be stored in the Key Vault. Defaults to an empty object."
  type        = map(string)
  sensitive   = true
  default     = {}
}

# Storage Account Variables
## Storage Account Resource Group
variable "storage_account_resource_group_name" {
  description = "The name of the resource group where the storage account will be created."
  type        = string
}

## Storage Account - Backup
variable "backup_storage_account_name" {
  description = "The name of the storage account for backups."
  type        = string
}

variable "backup_storage_account_kind" {
  description = "The kind of the storage account."
  type        = string

  validation {
    condition     = contains(["BlobStorage", "BlockBlobStorage", "FileStorage", "Storage", "StorageV2"], var.backup_storage_account_kind)
    error_message = "The Storage Account kind must be BlobStorage, BlockBlobStorage, FileStorage, Storage or StorageV2."
  }
}

variable "backup_storage_account_tier" {
  description = "The performance tier of the storage account."
  type        = string

  validation {
    condition = (
      contains(["Standard", "Premium"], var.backup_storage_account_tier) &&
      !contains(["BlockBlobStorage", "FileStorage"], var.backup_storage_account_kind) ||
      (contains(["BlockBlobStorage", "FileStorage"], var.backup_storage_account_kind) && var.backup_storage_account_tier == "Premium")
    )

    error_message = <<EOT
      The performance tier must be either 'Standard' or 'Premium'.
      When the storage account kind is 'BlockBlobStorage' or 'FileStorage', the tier must be 'Premium'.
      EOT
  }
}

variable "backup_storage_account_replication_type" {
  description = "The replication type of the storage account."
  type        = string

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.backup_storage_account_replication_type)
    error_message = "The Storage Account replication type LRS, GRS, RAGRS, ZRS, GZRS or RAGZRS."
  }
}

## Storage Account - Backup - Role Assignments
variable "backup_storage_account_role_assignments" {
  description = "A list of role assignments for the storage account. Defaults to an empty list."
  type = list(object({
    role_definition_name = string
    principal_id         = string
  }))
  default = []
}

## Storage Account - Backup - Longhorn Container
variable "longhorn_container_name" {
  description = "The name of the Longhorn container."
  type        = string
}

## Storage Account - Backup - Secrets
variable "st_backup_name_secret_name" {
  description = "The name of the storage account name secret for backups."
  type        = string
}

variable "st_backup_access_key_secret_name" {
  description = "The name of the storage account access key secret for backups."
  type        = string
}