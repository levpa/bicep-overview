# HOW TO

## Create ARM template from bicep

az bicep build --file main.bicep

## Create bicep from ARM template

az bicep decompile --file main.json

### Azure auth

```bash 
# set proper Azure subscription
az account list --output table
az account set --subscription <subscription_id>

# login and check
az login
az account show
```

### Create main resource group

```bash
# az cli
az group create --location westeurope --name levs-test-rg
# pwsh
New-AzResourceGroup -Location westeurope -Name levs-test-rg
```

### Create deployment

```bash
# deployment with Azure CLI
az deployment group create \
    --name LevsDeployment \
    --subscription "Avenga UA education" \
    --resource-group levs-test-rg \
    --mode Incremental \
    --template-file main.bicep \
    --parameters main.bicepparam
    # --what-if
```
