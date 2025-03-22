
resource "null_resource" "test_null" {
  provisioner "local-exec" {
    command = "echo ${var.subscription_id}"
  }
}

module "ResourceGroup" {
  source                = "../../modules/ResourceGroup"
  resource_group_prefix = var.resource_group_prefix
  github_environment    = var.github_environment
  tla                   = var.tla
  location_suffix       = var.location_suffix
  rg_location           = var.rg_location
}

module "StorageAccount" {
  source             = "../../modules/StorageAccount"
  github_environment = var.github_environment
  tla                = var.tla
  location-suffix    = var.location_suffix
  rgname             = join("-", [var.resource_group_prefix, var.github_environment, var.tla, var.location_suffix])
  rg-location        = var.resource_group_location
  depends_on         = [module.ResourceGroup]
}

module "EntraId" {
  source             = "../../modules/EntraId"
  github_environment = var.github_environment
  tla                = var.tla
}
module "UserAssignedMI" {
  source             = "../../modules/UserAssignedMI"
  github_environment = var.github_environment
  tla                = var.tla
  location-suffix    = var.location_suffix
  rgname             = join("-", [var.resource_group_prefix, upper(var.github_environment), upper(var.tla), var.location_suffix])
  rg-location        = var.resource_group_location
  depends_on         = [module.ResourceGroup]
}
module "KeyVault" {
  source             = "../../modules/KeyVault"
  github_environment = var.github_environment
  tla                = var.tla
  location-suffix    = var.location_suffix
  rgname             = join("-", [var.resource_group_prefix, upper(var.github_environment), upper(var.tla), var.location_suffix])
  rg-location        = var.resource_group_location
  postmanPassword    = module.AppRegistration.postmanPassword
  umi                = module.UserAssignedMI.UserAssignedMI
  uami_principal_id  = module.UserAssignedMI.uami_principal_id
  depends_on         = [module.ResourceGroup, module.UserAssignedMI, module.AppRegistration]
}

module "AppRegistration" {
  source             = "../../modules/AppRegistration"
  appname            = var.appname
  tla                = var.tla
  github_environment = var.github_environment
  sign_in_audience   = "AzureADandPersonalMicrosoftAccount"
  depends_on         = [module.ResourceGroup]
}
module "GitHub" {
  source = "../../modules/GitHub"
  domain             = module.AppRegistration.domain    #var.domain
  tenantid           = module.AppRegistration.tenantid  #var.arm_tenant_id
  clientid           = module.AppRegistration.clientid
  #Following variables are used to configure the GitHub Actions environment secrets
  github_token       = var.github_token
  github_owner       = var.github_owner
  github_environment = var.github_environment
  depends_on         = [module.ResourceGroup]
}

module "LAW" {
  source             = "../../modules/LAW"
  github_environment = var.github_environment
  tla                = var.tla
  location-suffix    = var.location_suffix
  rgname             = join("-", [var.resource_group_prefix, var.github_environment, var.tla, var.location_suffix])
  rg-location        = var.resource_group_location
  depends_on         = [module.ResourceGroup]
}

module "AppInsight" {
  source             = "../../modules/AppInsight"
  github_environment = var.github_environment
  tla                = var.tla
  location-suffix    = var.location_suffix
  rgname             = join("-", [var.resource_group_prefix, var.github_environment, var.tla, var.location_suffix])
  rg-location        = var.resource_group_location
  law_id             = module.LAW.log_analytics_workspace_id
  depends_on         = [module.ResourceGroup, module.LAW]
}

module "AppService" {
  source                = "../../modules/AppService"
  github_environment    = var.github_environment
  tla                   = var.tla
  location-suffix       = var.location_suffix
  rgname                = join("-", [var.resource_group_prefix, var.github_environment, var.tla, var.location_suffix])
  rg-location           = var.resource_group_location
  app_service_plan_name = join("_", ["asp", var.github_environment, var.tla, var.location_suffix])
  uami_principal_id     = module.UserAssignedMI.UserAssignedMI
  instrumentation_key   = module.AppInsight.instrumentation_key
  connection_string     = module.AppInsight.connection_string
  depends_on = [
    module.ResourceGroup,
    module.UserAssignedMI,
    module.AppInsight
  ]
}