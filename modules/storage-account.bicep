
@description('Location of the resources')
param location string = 'westeurope'

@description('Tags for the resources')
param tags object = {}

@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('Name of the storage account sku')
param storageAccountSku string

@description('Support HTTPs traffic only')
param supoprtsHttpsTrafficOnly bool = true

@description('Names of the containers to deploy')
param containerNames array = []

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  tags: tags
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: supoprtsHttpsTrafficOnly
  }
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = if(!(empty(containerNames))) {
    name: 'default'
    parent: storageAccount
}

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = [ 
  for containerName in containerNames: {
    name: containerName
    parent: blobServices
    properties: {
      publicAccess: 'None'
    }}
  ]

output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
