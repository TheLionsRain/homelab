// MARK: Usings
using '../main.bicep'

// MARK: Variables
var location = 'northeurope'
var locationShortName = 'ne'
var environment = 'helheim'
var tags = {
  Environment: environment
  Project: 'Homelab'
  Purpose: 'K8S Cluster'
  CreatedWith: 'Bicep'
  Owner: 'Michiel Van Herreweghe'
}
// MARK: Parameters
// MARK: Key Vault Resources
param resourceGroupKeyVaultToCreate = {
  name: 'rg-homelab-${environment}-kv-${locationShortName}'
  location: location
  tags: tags
}

param keyVaultToCreate = {
  name: 'kv-homelab-${environment}-${locationShortName}'
  location: location
  tags: tags
  sku: {
    name: 'standard'
  }
  enableSoftDelete: false
  secrets: [
    {
      name: 'cloudflare-api-token'
      value: '#{CLOUDFLARE_API_TOKEN}#'
    }
  ] 
}
