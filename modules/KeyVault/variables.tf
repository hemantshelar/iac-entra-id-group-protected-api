variable "github_environment" {
  description = "The environment name"
  type        = string
}

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


variable "umi" {
  description = "The user managed identity"
  type        = string  
}

variable "uami_principal_id" {
  description = "The user managed identity principal id"
  type        = string
}

variable "postmanPassword" {
  description = "The postman password"
  type        = string
}