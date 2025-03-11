terraform {
required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}

/*provider "github" {
  token = "token here"
  owner = "hemantshelar"
}*/

resource "github_actions_environment_secret" "clientid" {
  repository       = "entra-id-group-protected-api"
  environment      = "Development"
  secret_name      = "CLIENTID"
  plaintext_value  = "id" 
}

/*resource "github_actions_environment_secret" "domain" {
  repository       = "entra-id-group-protected-api"
  environment      = var.github_environment
  secret_name      = "DOMAIN"
  plaintext_value  = "${var.domain}" 
}

resource "github_actions_environment_secret" "tenantid" {
  repository       = "entra-id-group-protected-api"
  environment      = var.github_environment
  secret_name      = "TENANTID"
  plaintext_value  = "${var.tenantid}" 
}*/