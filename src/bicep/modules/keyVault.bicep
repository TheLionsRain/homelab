// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Imports
import { KeyVault } from 'types.bicep'

// MARK: Parameters
param keyVault KeyVault

// MARK: Resources
resource kv 'Microsoft.KeyVault/vaults@2024-12-01-preview' = {
  name: keyVault.name
  location: keyVault.location
  properties: {
    sku: {
      name: keyVault.sku.name
      family: 'A'
    }
    enableSoftDelete: keyVault.enableSoftDelete
    softDeleteRetentionInDays: keyVault.?softDeleteRetentionInDays
    enableRbacAuthorization: true
    tenantId: tenant().tenantId
  }
}

resource secrets 'Microsoft.KeyVault/vaults/secrets@2024-12-01-preview' = [
  for secret in keyVault.secrets: {
    name: secret.name
    properties: {
      value: secret.value
      contentType: secret.?contentType
    }
  }
]

// MARK: Outputs
output id string = kv.id
output name string = kv.name
output location string = kv.location
