
terraform {
  required_version = "~>1.0, < 2.0"

  required_providers {
    azuread = {
      ## Azure AD (Entra ID)
      source  = "hashicorp/azuread"
      version = "~>3.0, < 4.0"
    }
    msgraph = {
      ## Microsoft Graph - replacement for azuread *future*
      version = "~> 0.0, < 1.0"
      source  = "Microsoft/msgraph"
    }
    random = {
      ## Random
      source  = "hashicorp/random"
      version = "~>3.0, < 4.0"
    }
  }
}

provider "azurerm" {
  alias           = "management"
  subscription_id = var.subscription_id
  features {}
}

provider "msgraph" {
  ## Configuration options
  use_oidc                  = true
  use_aks_workload_identity = false
  use_msi                   = false
  use_cli                   = true
}

provider "azuread" {
  ## Configuration options
  alias     = "workforce" ## provider = azuread.workforce
  tenant_id = var.workforce_tenant_id
  client_id = var.workforce_client_id
  # Authentication strategy: Using OIDC and Azure CLI for authentication to Azure AD tenant.
  use_oidc = true
  use_cli  = true
}

