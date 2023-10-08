# deployment with Azure CLI
az deployment group create \
    --name LevsDeployment \
    --subscription "Avenga UA education" \
    --resource-group levs-test-rg \
    --mode Incremental \
    --template-file main.bicep \
    --parameters main.bicepparam
    # --what-if
