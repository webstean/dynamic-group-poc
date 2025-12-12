terraform {
  required_version = "~>1.0, < 2.0"

  required_providers {
    azurerm = {
      ## Azure Resource Manager
      source  = "hashicorp/azurerm"
      version = "~>4.0, < 5.0"
    }
    msgraph = {
      ## Microsoft Graph - replacement for azuread *future*
      source  = "Microsoft/msgraph"
      version = "~> 0.0, < 1.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "andrewwebster"
    storage_account_name = "tfwqaesdfghfd"
    container_name       = "tfstate"
    key                  = "dynamic-group-poc-msgraph"
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  use_aks_workload_identity = false
  use_msi                   = false
  # Authentication strategy: Using OIDC (GitHub Actions) and Azure CLI (interactive) for authentication to Azure AD tenant.
  use_oidc = true
  use_cli  = true
}

provider "msgraph" {
  use_aks_workload_identity = false
  use_msi                   = false
  # Authentication strategy: Using OIDC (GitHub Actions) and Azure CLI (interactive) for authentication to Azure AD tenant.
  use_oidc = true
  use_cli  = true
}
