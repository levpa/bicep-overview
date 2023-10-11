using './main.bicep'

param storageAccountName = 'levssecstorageacc'
param auditStorageAccountName = 'levsthirdstorageacc'
param storageAccountSku = 'Standard_LRS'

param tags = {
    owner: 'Lev Pa'
    env: 'dev'
}
