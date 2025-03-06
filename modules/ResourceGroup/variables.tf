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
    type = string
    description = "Environment name."
    default = "Development"
}