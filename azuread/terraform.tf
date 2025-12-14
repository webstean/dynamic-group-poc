
terraform {
  required_version = "~>1.0, < 2.0"

  required_providers {
    azurerm = {
      ## Azure Resource Manager
      source  = "hashicorp/azurerm"
      version = "~>4.0, < 5.0"
    }
    azuread = {
      ## Azure AD (Entra ID)
      source  = "hashicorp/azuread"
      version = "~>3.0, < 4.0"
    }
    msgraph = {
      ## Microsoft Graph
      source  = "Microsoft/msgraph"
      version = "~> 0.0, < 1.0"
    }
    random = {
      ## Random
      source  = "hashicorp/random"
      version = "~>3.0, < 4.0"
    }
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

provider "azuread" {
  use_aks_workload_identity = false
  use_msi                   = false
  ## Authentication strategy: Using OIDC (GitHub Actions) and Azure CLI (interactive) for authentication to Azure AD tenant.
  use_oidc = true
  use_cli  = true
}

provider "msgraph" {
  use_aks_workload_identity = false
  use_msi                   = false
  ## Authentication strategy: Using OIDC (GitHub Actions) and Azure CLI (interactive) for authentication to Azure AD tenant.
  use_oidc = true
  use_cli  = true
}

