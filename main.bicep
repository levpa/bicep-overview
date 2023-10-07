resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'levsbicepstacc'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: 'levsauditstacc'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}
