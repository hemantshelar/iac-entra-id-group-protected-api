
resource "null_resource" "test_null" {
  provisioner "local-exec" {
    command = "echo ${var.subscription_id}"
  }
}

module "ResourceGroup" {
  source          = "../../modules/ResourceGroup"
  env             = "dev"
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  rg-location     = "australiaeast"
  environment     = "Development"
}

module "AppService" {
  source                = "../../modules/AppService"
  env                   = "dev"
  tla                   = "p01"
  location-suffix       = "aae"
  rgname                = "rg-dev-p01-aae"
  rg-location           = "australiaeast"
  environment           = "Development"
  app_service_plan_name = "test"
  uami_principal_id     = module.UserAssignedMI.UserAssignedMI
  instrumentation_key   = module.AppInsight.instrumentation_key
  connection_string     = module.AppInsight.connection_string
  depends_on = [
    module.ResourceGroup,
    module.UserAssignedMI,
    module.AppInsight

  ]
}

module "StorageAccount" {
  source          = "../../modules/StorageAccount"
  env             = "dev"
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  rg-location     = "australiaeast"
  environment     = "Development"
  depends_on      = [module.ResourceGroup]
}


module "UserAssignedMI" {
  source          = "../../modules/UserAssignedMI"
  env             = "dev"
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  rg-location     = "australiaeast"
  environment     = "Development"
  depends_on      = [module.ResourceGroup]
}

module "KeyVault" {
  source            = "../../modules/KeyVault"
  env               = "dev"
  tla               = "p01"
  location-suffix   = "aae"
  rgname            = "rg-dev-p01-aae"
  rg-location       = "australiaeast"
  environment       = "Development"
  postmanPassword   = module.AppRegistration.postmanPassword
  depends_on        = [module.ResourceGroup, module.UserAssignedMI, module.AppRegistration]
  umi               = module.UserAssignedMI.UserAssignedMI
  uami_principal_id = module.UserAssignedMI.uami_principal_id
}

module "EntraId" {
  source          = "../../modules/EntraId"
  env             = "dev"
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  environment     = "Development"
  rg-location     = "australiaeast"
}

module "LAW" {
  source          = "../../modules/LAW"
  env             = "dev"
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  rg-location     = "australiaeast"
  environment     = "Development"
  depends_on      = [module.ResourceGroup]
}

module "AppInsight" {
  source          = "../../modules/AppInsight"
  env             = "dev"
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  rg-location     = "australiaeast"
  environment     = "Development"
  law_id          = module.LAW.log_analytics_workspace_id
  depends_on      = [module.ResourceGroup, module.LAW]
}


module "AppRegistration" {
  source = "../../modules/AppRegistration"
}