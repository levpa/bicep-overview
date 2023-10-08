
@description('Location of the resources')
param location string = 'westeurope'

@description('Tags for the resources')
param tags object = {}

@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

@maxLength(24)
@description('Name of the audit account')
param auditStorageAccountName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('Name of the storage account sku')
param storageAccountSku string

var storageAccountKind = 'StorageV2'

@description('Support HTTPS traffic only')
param supportHttpsTraffic bool = true

var storageAccountProperties = {
  minimumTlsVersion: 'TLS1_2'
  supportsHttpsTrafficOnly: supportHttpsTraffic
}



resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  tags: tags
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: storageAccountProperties
}

resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: auditStorageAccountName
  tags: tags
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: storageAccountProperties
}

// extract keys from objects
var storageAccountKey = storageAccount.listKeys().keys[0]

output storageAccountName string = storageAccount.name
output auditStorageAccountName string = auditStorageAccount.name

output storageAccountId string = storageAccount.id
output auditStorageAccountId string = auditStorageAccount.id
