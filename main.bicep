
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

var storageAccountNames = deployAuditStorageAccount ? [
        storageAccount.outputs.storageAccountName
        auditStorageAccount.outputs.storageAccountName
      ]:[
        storageAccount.outputs.storageAccountName
      ]

// var storageBlobDataReaderId = '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'

// module roleAssignments 'modules/storage-account-role-assignments.bicep' = {
//   name: 'deploy-role-assignments'
//   params: {
//     adGroupId: '3b83321f-7bea-4370-8e8f-501f15e7940c'
//     roleAssignmentId: storageBlobDataReaderId
//     storageAccountNames: storageAccountNames
//   }
//   // dependsOn: [
//   //   storageAccount
//   //   auditStorageAccount
//   // ]
// }

output storageAccountName string = storageAccount.outputs.storageAccountName
output auditStorageAccountName string = auditStorageAccount.outputs.storageAccountName

output storageAccountId string = storageAccount.outputs.storageAccountId
output auditStorageAccountId string = auditStorageAccount.outputs.storageAccountId
