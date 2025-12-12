##azurerm
data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}
data "azurerm_subscriptions" "available" {}
## azuread
data "azuread_client_config" "current" {}

