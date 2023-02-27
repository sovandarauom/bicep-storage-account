### Deploy bicep template

```
az deployment group create --resource-group azure_Learning --template-file main.bicep
```

### Clean up

```
az resource delete -g azure_Learning -n sovandarauomstoragebicep --resource-type "Microsoft.Storage/storageAccounts"
```

### Referrence

```
https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-cli
```