var minimumTlsVersion = 'TLS1_2'
var supportHttpsTrafficOnly = true

var myFirstInteger = 10

var myFirstObject = {
  myFirstKey: 'myFirstValue'
  mySecondKey: 100
}

var myFirstValue = myArray[1]
var myObjectValue = myFirstObject.myFirstKey

var nestedObjects = {
  myFirstObject: {
    anotherObject: {

    }
  }
}

@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

// string
var myFirstString = 'mystring${storageAccountName}'
var lowerCase = toLower(myFirstString)
var upperCase = toUpper(myFirstString)
var trimmed = trim(' spaces ')
var sub = substring(trimmed, 0, 2)

// data conversions
var myBool = bool('true')
var myInteger = int('10')
var myString = string(10)

// arrays

var myArray = [
  'mystring'
  'myotherstring'
]

var mySecondArray = [
  'mystring'
  'myotherstring'
]

var firstElement = first(myArray)
var arrayContains = contains(myArray, 'mystring')
var isArrayEmpty = empty(myArray)

var splitString = split('header1, header2, header3', ',')

var combinedArray = concat(myArray, mySecondArray)
var unionArray = union(myArray, mySecondArray)

// scope functions
var resourceGroupName = resourceGroup().name
var subscriptionId = subscription().id

// loading files
var loadedJson = loadJsonContent('example.json')
var jsonContent = loadedJson.storageAccounts[0].name

var loadedYaml = loadYamlContent('example.yml')
var yamlContent = loadedYaml.name

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
}

// extract keys from objects
var storageAccountKey = storageAccount.listKeys().keys[0]

var storageAccountKind = 'StorageV2'

@description('Support HTTPS traffic only')
param supportHttpsTraffic bool = true

// object variables
var storageAccountProperties = {
  minimumTlsVersion: 'TLS1_2'
  supportsHttpsTrafficOnly: supportHttpsTraffic
}
