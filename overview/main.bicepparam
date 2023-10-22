using 'main.bicep'

param storageAccountName = 'levssecstorageacc'
param auditStorageAccountName = 'levsthirdstorageacc'
param storageAccountSku = 'Standard_LRS'
param mySecret = 'some_secret'
param tags = {
    owner: 'Lev Pa'
    env: 'dev'
}
