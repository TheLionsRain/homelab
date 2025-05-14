// MARK: Resource Group
@export()
type ResourceGroup = {
  name: string
  location: string
  tags: object
}

// MARK: Key Vault
@export()
type KeyVault = {
  name: string
  location: string
  tags: object
  sku: {
    name: ('premium' | 'standard')
  }
  enableSoftDelete: bool
  softDeleteRetentionInDays: int?
  secrets: KeyVaultSecret[]
}

type KeyVaultSecret = {
  name: string
  value: string
  contentType: string?
}
