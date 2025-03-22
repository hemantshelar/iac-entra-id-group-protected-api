variable "tla" {
  description = "The project name"
  type        = string
}
variable "github_environment" {
  description = "The environment name"
  type        = string
}

variable "appname" {
  description = "The name of the application"
  type        = string
  
}
variable "sign_in_audience" {
  description = "The sign in audience"
  type        = string
  default     = "AzureADandPersonalMicrosoftAccount"
}