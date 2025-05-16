// MARK: Target Scope
targetScope = 'subscription'

// MARK: Imports
import { ResourceGroup, KeyVault } from 'modules/types.bicep'

// MARK: Parameters
param resourceGroupKeyVaultToCreate ResourceGroup
param keyVaultToCreate KeyVault

// MARK: Variables

// MARK: Resources
// MARK: Key Vault Resources
resource resourceGroupKeyVault 'Microsoft.Resources/resourceGroups@2025-03-01' = {
  name: resourceGroupKeyVaultToCreate.name
  location: resourceGroupKeyVaultToCreate.location
  tags: resourceGroupKeyVaultToCreate.tags
}

module keyVault 'modules/keyVault.bicep' = {
  scope: resourceGroupKeyVault
  params: {
    keyVault: keyVaultToCreate
  }
}
