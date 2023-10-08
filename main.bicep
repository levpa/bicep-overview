
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

module storageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${storageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
  }
}

var auditStorageAccountContainers = [
  'data'
  'logs'
]

module auditStorageAccount 'modules/storage-account.bicep' = {
  name: 'deploy-${auditStorageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: auditStorageAccountName
    storageAccountSku: storageAccountSku
    containerNames: auditStorageAccountContainers
  }
}

output storageAccountName string = storageAccount.outputs.storageAccountName
output auditStorageAccountName string = auditStorageAccount.outputs.storageAccountName

output storageAccountId string = storageAccount.outputs.storageAccountId
output auditStorageAccountId string = auditStorageAccount.outputs.storageAccountId
