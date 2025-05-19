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