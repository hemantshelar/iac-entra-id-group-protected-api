
module "ResourceGroup" {
  source          = "../../modules/ResourceGroup"
  env             = "uat"
  tla             = "tfdemo"
  location-suffix = "aae"
  rgname          = "rg-uat-tfdemo-aae"
  rg-location     = "australiaeast"
  environment     = "UAT"
}

module "AppService" {
  source                = "../../modules/AppService"
  env                   = "uat"
  tla                   = "tfdemo"
  location-suffix       = "aae"
  rgname                = "rg-uat-tfdemo-aae"
  rg-location           = "australiaeast"
  environment           = "UAT"
  app_service_plan_name = "test"
  uami_principal_id     = module.UserAssignedMI.UserAssignedMI
  depends_on = [
    module.ResourceGroup,
    module.UserAssignedMI
  ]
}

module "StorageAccount" {
  source          = "../../modules/StorageAccount"
  env             = "uat"
  tla             = "tfdemo"
  location-suffix = "aae"
  rgname          = "rg-uat-tfdemo-aae"
  rg-location     = "australiaeast"
  environment     = "UAT"
  depends_on      = [module.ResourceGroup]
}


module "UserAssignedMI" {
  source          = "../../modules/UserAssignedMI"
  env             = "uat"
  tla             = "tfdemo"
  location-suffix = "aae"
  rgname          = "rg-uat-tfdemo-aae"
  rg-location     = "australiaeast"
  environment     = "UAT"
  depends_on      = [module.ResourceGroup]
}

module "KeyVault" {
  source          = "../../modules/KeyVault"
  env             = "uat"
  tla             = "tfdemo"
  location-suffix = "aae"
  rgname          = "rg-uat-tfdemo-aae"
  rg-location     = "australiaeast"
  environment     = "UAT"
  depends_on      = [module.ResourceGroup, module.UserAssignedMI]
}

module "EntraId" {
  source          = "../../modules/EntraId"
  env             = "uat"
  tla             = "tfdemo"
  location-suffix = "aae"
  rgname          = "rg-uat-tfdemo-aae"
  environment     = "UAT"
  rg-location     = "australiaeast"
}

module "LAW" {
  source          = "../../modules/LAW"
  env             = "uat"
  tla             = "tfdemo"
  location-suffix = "aae"
  rgname          = "rg-uat-tfdemo-aae"
  rg-location     = "australiaeast"
  environment     = "UAT"
  depends_on      = [module.ResourceGroup]
}

module "AppInsight" {
  source          = "../../modules/AppInsight"
  env             = "uat"
  tla             = "tfdemo"
  location-suffix = "aae"
  rgname          = "rg-uat-tfdemo-aae"
  rg-location     = "australiaeast"
  environment     = "UAT"
  law_id          = module.LAW.log_analytics_workspace_id
  depends_on      = [module.ResourceGroup, module.LAW]
}