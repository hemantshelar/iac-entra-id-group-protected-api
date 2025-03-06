terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.21.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "hftfstate"
    container_name       = "tfstate"
    key                  = "tfdemo.dev.tfstate"
  }
}

provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = false #Fix for : Key valut taking long time to delete KV
    }
  }
}

provider "azuread" {
  # Configuration options
}