using './main.bicep'

param storageAccountName = 'levsbicepstacc'
param auditStorageAccountName = 'levsauditstacc'
param storageAccountSku = 'Standard_LRS'

param tags = {
    owner: 'Lev Pa'
    env: 'dev'
}
