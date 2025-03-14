variable "resource_group_location" {
  type        = string
  default     = "Australia East"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "github_environment" {
  type        = string
  description = "The environment for the resources in this example."
  validation {
    condition     = can(contains(["dev", "test", "prod"], var.environment))
    error_message = "The environment must be either dev, test, or prod."
  }
}

variable "subscription_id" {
  type        = string
  description = "The Azure subscription ID."
  sensitive   = true
}

variable "arm_tenant_id" {
  type        = string
  description = "The tenant ID."
}

variable "arm_client_id" {
  type        = string
  description = "The client ID."
}

variable "arm_client_secret" {
  type        = string
  description = "The client secret."
  sensitive   = true
}

variable "domain" {
  type        = string
  description = "The domain."
}

variable "github_token" {
  type        = string
  description = "The GitHub token."
  sensitive   = true
}

variable "github_owner" {
  type        = string
  description = "The GitHub owner."
}