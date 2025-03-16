variable "resource_group_prefix" {
  description = "The prefix for the resource group"
  type        = string
}
variable "github_environment" {
    type = string
    description = "Environment name."
}
variable "tla" {
  description = "The project name"
  type        = string
}
variable "location_suffix" {
  description = "The location suffix"
  type        = string
}

variable "rg_location" {
  description = "The resource group location"
  type        = string
}
