$env:RESOURCE_GROUP_NAME='rg-tfstate'
$env:STORAGE_ACCOUNT_NAME='hftfstate'
$env:CONTAINER_NAME='tfstate'

# Create resource group
az group create --name $env:RESOURCE_GROUP_NAME --location 'australiaeast'

# Create storage account
az storage account create --resource-group $env:RESOURCE_GROUP_NAME --name $env:STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $env:CONTAINER_NAME --account-name $env:STORAGE_ACCOUNT_NAME

# This account key will be used by Terraform to authenticate
$ACCOUNT_KEY=$(az storage account keys list --resource-group $env:RESOURCE_GROUP_NAME --account-name  $env:STORAGE_ACCOUNT_NAME  --query '[0].value' -o tsv)
$env:ARM_ACCESS_KEY=$ACCOUNT_KEY