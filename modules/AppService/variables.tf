variable "tla" {
  description = "The project name"
  type        = string
}

variable "location-suffix" {
  description = "The location suffix"
  type        = string
}

variable "rgname" {
  description = "The resource group name"
  type        = string
}
variable "rg-location" {
  description = "The resource group location"
  type        = string
}
variable "github_environment" {
  description = "The environment name"
  type        = string
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
}

variable "uami_principal_id" {
  type = string
  default = ""
}

variable "instrumentation_key" {
  type = string
}

variable "connection_string" {
  type = string
}