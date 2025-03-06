variable "env" {
  description = "The environment name"
  type        = string
  default = "value"
}

variable "tla" {
  description = "The project name"
  type        = string
  default = "value"
}

variable "location-suffix" {
  description = "The location suffix"
  type        = string
  default = "value"
}

variable "rgname" {
  description = "The resource group name"
  type        = string
  default = "value"
}
variable "rg-location" {
  description = "The resource group location"
  type        = string
  default = "value"
}
variable "environment" {
  description = "The environment name"
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