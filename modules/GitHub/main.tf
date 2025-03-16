terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.6.0"
    }   
  }
}

resource "github_actions_environment_secret" "clientid" {
  repository       = "entra-id-group-protected-api"
  environment      = var.github_environment
  secret_name      = "CLIENTID"
  plaintext_value  = "id" 
}

resource "github_actions_environment_secret" "domain" {
  repository       = "entra-id-group-protected-api"
  environment      = var.github_environment
  secret_name      = "DOMAIN"
  plaintext_value  = var.domain
}

resource "github_actions_environment_secret" "tenantid" {
  repository       = "entra-id-group-protected-api"
  environment      = var.github_environment
  secret_name      = "TENANTID"
  plaintext_value  = var.tenantid
}