@description('name of storage account')
param storageAccountNames array

@description('ID of the AD group for role assignment')
param adGroupId string

@description('ID of the RBAC role definition')
param roleAssignmentId string


resource role 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: roleAssignmentId
}

resource storageAccounts 'Microsoft.Storage/storageAccounts@2023-01-01' existing = [
  for storageAccountName in storageAccountNames: {
    name: storageAccountName
    // scope: resourceGroup('myOtherResourceGroup')
  }]

resource roleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for i in range(0, length(storageAccountNames)): {
    name: guid(storageAccounts[i].name, role.id, adGroupId)
    scope: storageAccounts[i]
    properties: {
      principalId: role.id
      roleDefinitionId: adGroupId
    }
  }]
