
resource "null_resource" "test_null" {
  provisioner "local-exec" {
    command = "echo ${var.subscription_id}"
  }
}

module "ResourceGroup" {
  source          = "../../modules/ResourceGroup"
  github_environment = var.github_environment
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  rg-location     = "australiaeast"
}


/*
module "AppService" {
  source                = "../../modules/AppService"
  github_environment = var.github_environment
  tla                   = "p01"
  location-suffix       = "aae"
  rgname                = "rg-dev-p01-aae"
  rg-location           = "australiaeast"
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
  github_environment = var.github_environment
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  rg-location     = "australiaeast"
  depends_on      = [module.ResourceGroup]
}


module "UserAssignedMI" {
  source          = "../../modules/UserAssignedMI"
  github_environment = var.github_environment
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  rg-location     = "australiaeast"
  depends_on      = [module.ResourceGroup]
}

module "KeyVault" {
  source            = "../../modules/KeyVault"
  github_environment = var.github_environment
  tla               = "p01"
  location-suffix   = "aae"
  rgname            = "rg-dev-p01-aae"
  rg-location       = "australiaeast"
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
  github_environment = var.github_environment
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  rg-location     = "australiaeast"
  depends_on      = [module.ResourceGroup]
}

module "AppInsight" {
  source          = "../../modules/AppInsight"
  github_environment = var.github_environment
  tla             = "p01"
  location-suffix = "aae"
  rgname          = "rg-dev-p01-aae"
  rg-location     = "australiaeast"
  law_id          = module.LAW.log_analytics_workspace_id
  depends_on      = [module.ResourceGroup, module.LAW]
}

module "AppRegistration" {
  source = "../../modules/AppRegistration"
}*/
module "GitHub" {
  source = "../../modules/GitHub"
  #clientid           = module.AppRegistration.clientid
  clientid = "test"
  #Following variables are used to configure the GitHub Actions environment secrets
  domain             = var.domain
  tenantid           = var.arm_tenant_id
  github_token       = var.github_token
  github_owner       = var.github_owner
  github_environment = var.github_environment
  depends_on         = [module.ResourceGroup]
}