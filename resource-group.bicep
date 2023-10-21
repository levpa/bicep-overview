@description('Specifies the location for resources.')
param location string = 'westeurope'

targetScope = 'subscription'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'levsnewresourcegroup'
  location: location
}
