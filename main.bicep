// StorageAccount.bicep
param storageAccountName string = 'sovandarauomstoragebicep'
param location string = resourceGroup().location
param tags object = {}
param storageAccountSku string = 'Standard_LRS'
param storageAccountType string = 'StorageV2'
param containerNames array = ['pending', 'processing', 'done', 'failed']

// Create storage
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountType
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  name: '${storageAccount.name}/default'
}

// Create containers if specified
resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = [for containerName in containerNames: {
  parent: blobService
  name: !empty(containerNames) ? '${toLower(containerName)}' : 'placeholder'
  properties: {
    publicAccess: 'None'
    metadata: {}
  }
}]

output name string = storageAccount.name
