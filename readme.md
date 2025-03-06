## Create storage account for tfstate

`az login`

 terraform init --upgrade
 terraform init -reconfigure

 az login --tenant 9e8754b6-f9cd-4aed-974d-a0ec0f3ed703

 terraform plan -out main.tfplan

 terraform apply main.tfplan

 terraform plan -destroy -out main.destroy.tfplan

terraform apply main.destroy.tfplan



[Github Action](https://www.youtube.com/watch?v=Ah17o_1bryo) to enable CI/CD.


Follow [thi](https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure-with-service-principle?tabs=bash) article for creating service principal

az ad sp create-for-rbac --name SPN_TERRAFORM_GLOBAL --role Contributor --scopes /subscriptions/cffaa289-ca3b-4126-81da-eb8bc9ef39e9

export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"


In order to initialize a variable from environment variable, follow the steps. [Stack Overflow reference](https://stackoverflow.com/questions/36629367/getting-an-environment-variable-in-terraform-configuration)
- define a variable in variables.tf file.
```
variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID."
}
```
- export an environment variable with name TF_VAR_subscription_id
```
export TF_VAR_subscription_id="#########"
```
```
$env:TF_VAR_subscription_id="#######"
```

**TROUBLESHOOTING**

- Storage Account Name: "strguattfdemoaae"): unexpected status 409 (409 Conflict) with error: StorageAccountOperationInProgress: An operation is currently performing on this storage account that requires exclusive access.


Error: A resource with the ID "/subscriptions/cffaa289-ca3b-4126-81da-eb8bc9ef39e9/resourceGroups/rg-dev-tfdemo-aae/providers/Microsoft.Storage/storageAccounts/strgdevtfdemoaae" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_storage_account" for more information.


rror: Creating user "usrdevtfdemo@NETORGFT17726763.onmicrosoft.com"
│
│   with module.EntraId.azuread_user.envuser,
│   on ..\..\modules\EntraId\main.tf line 3, in resource "azuread_user" "envuser":
│    3: resource "azuread_user" "envuser" {
│
│ unexpected status 403 (403 Forbidden) with error: Authorization_RequestDenied: Insufficient privileges to complete the operation.
╵
╷
│ Error: Creating group "GRP-dev-tfdemo-contributors"
│
│   with module.EntraId.azuread_group.envcontributors,
│   on ..\..\modules\EntraId\main.tf line 10, in resource "azuread_group" "envcontributors":
│   10: resource "azuread_group" "envcontributors" {
│
│ unexpected status 403 (403 Forbidden) with error: Authorization_RequestDenied: Insufficient privileges to complete the operation.
╵
╷
│ Error: authorization.RoleAssignmentsClient#Create: Failure responding to request: StatusCode=403 -- Original Error: autorest/azure: Service returned an error. Status=403 Code="AuthorizationFailed" Message="The client '3a298f38-722e-40dc-bc28-60d7063e7214' with object id '3a298f38-722e-40dc-bc28-60d7063e7214' does not have authorization to perform action 'Microsoft.Authorization/roleAssignments/write' over scope '/subscriptions/cffaa289-ca3b-4126-81da-eb8bc9ef39e9/resourceGroups/rg-dev-tfdemo-aae/providers/Microsoft.KeyVault/vaults/kv-dev-tfdemo-aae/providers/Microsoft.Authorization/roleAssignments/ea1195e5-16b1-fa8b-a2a4-e384b614ef18' or the scope is invalid. If access was recently granted, please refresh your credentials."

- To solve above issue SPN was given a 'Owner' role for the subscription.

Error locking state: Error acquiring the state lock: state blob is already locked
[Break the lease](https://stackoverflow.com/questions/64690427/error-locking-state-error-acquiring-the-state-lock-state-blob-is-already-locke)