
@description('Location of the resources')
param location string = resourceGroup().location

@description('Tags for the resources')
param tags object = {}

@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

@maxLength(24)
@description('Name of the audit account')
param auditStorageAccountName string

@description('Deploy audit storage account option')
param deployAuditStorageAccount bool = true

@description('Deploy audit storage account option')
param deployAuditStorageAccountContainer bool = true

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('Name of the storage account sku')
param storageAccountSku string

@secure()
param mySecret string

var blobEndpoint = storageAccount.outputs.blobEndpoint
// @maxLength(10)
// @description('The short name of the storage account')
// param storageAccountShortName string

// @allowed([
//   'dev'
//   'uat'
//   'prd'
// ])
// @description('The environment of the deployment')
// param environment string

// var myResourceName = '${storageAccountShortName}-${environment}-${uniqueString(resourceGroup().id)}'

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
// account for audit logs
module auditStorageAccount 'modules/storage-account.bicep' = if (deployAuditStorageAccount) {
  name: 'deploy-${auditStorageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: auditStorageAccountName
    storageAccountSku: storageAccountSku
    containerNames: deployAuditStorageAccountContainer ? auditStorageAccountContainers : []
  }
}

// var storageAccountNames = deployAuditStorageAccount ? [
//         storageAccount.outputs.storageAccountName
//         auditStorageAccount.outputs.storageAccountName
//       ]:[
//         storageAccount.outputs.storageAccountName
//       ]

// var storageBlobDataReaderId = '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'

// module roleAssignments 'modules/storage-account-role-assignments.bicep' = {
//   name: 'deploy-role-assignments'
//   params: {
//     adGroupId: '02a910dd-b396-479a-ae3d-2605f5884901'
//     roleAssignmentId: storageBlobDataReaderId
//     storageAccountNames: storageAccountNames
//   }
// }

output storageAccountName string = storageAccount.outputs.storageAccountName
output auditStorageAccountName string = auditStorageAccount.outputs.storageAccountName

output storageAccountId string = storageAccount.outputs.storageAccountId
output auditStorageAccountId string = auditStorageAccount.outputs.storageAccountId
