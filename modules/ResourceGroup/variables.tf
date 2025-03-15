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
    type = string
    description = "Environment name."
}