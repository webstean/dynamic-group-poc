##azurerm
data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}
data "azurerm_subscriptions" "available" {}
## azuread
data "azuread_client_config" "current" {}
## azapi
data "azapi_client_config" "current" {}


#data "azuread_user" "andreww" {
#  user_principal_name = ""
#}

data "azuread_domains" "admin" {
  admin_managed = true
}

data "azuread_domains" "admin-external" {
  admin_managed = true
}

data "azuread_application_published_app_ids" "well_known" {
  provider = azuread.workforce
}

## Make sure these Service Principals (Enterprise Application) exist in the tenancy

resource "azuread_service_principal" "microsoft365" {   ## what the portal calls "Office 365"
  client_id    = "00000003-0000-0ff1-ce00-000000000000" ## Office 365 Sharepoint Online
  use_existing = true
}
## azuread_service_principal.microsoft365.client_id

resource "azuread_service_principal" "microsoft365_admin" {
  client_id    = "00b41c95-dab0-4487-9791-b9d2c32c80f2" ## Office 365 Management 
  use_existing = true
}
## azuread_service_principal.microsoft365_admin.client_id

resource "azuread_service_principal" "windows365" { ## Windows 365
  client_id    = "0af06dc6-e4b5-4f28-818e-e78e62d137a5"
  use_existing = true
}

resource "azuread_service_principal" "microsoft_edge" {
  client_id    = "ecd6b820-32c2-49b6-98a6-444530e5a77a" ## Microsoft Edge
  use_existing = true
}
## azuread_service_principal.microsoft_edge.client_id

resource "azuread_service_principal" "azure_portal" {
  client_id    = "c44b4083-3bb0-49c1-b47d-974e53cbdf3c" ## Azure Portal
  use_existing = true
}
## azuread_service_principal.azure_portal.client_id

resource "azuread_service_principal" "mysignin" {
  client_id    = "19db86c3-b2b9-44cc-b339-36da233a3be2" ## My Signins
  use_existing = true
}
## azuread_service_principal.mysignin.client_id

resource "azuread_service_principal" "devportal" {
  client_id    = "0140a36d-95e1-4df5-918c-ca7ccd1fafc9" ## Microsoft Developer Portal
  use_existing = true
}
## azuread_service_principal.devportal.client_id

resource "azuread_service_principal" "github_cps" {
  client_id    = "85c49807-809d-4249-86e7-192762525474" ## GitHub CPS Network Service
  use_existing = true
}
## azuread_service_principal.github_cps.client_id

resource "azuread_service_principal" "github_action_api" {
  client_id    = "4435c199-c3da-46b9-a61d-76de3f2c9f82" ## GitHub Actions API
  use_existing = true
}
## azuread_service_principal.github_action_api.client_id

resource "azuread_service_principal" "copilot_m365" {
  client_id    = "fb8d773d-7ef8-4ec0-a117-179f88add510" ## Microsoft 365 Copilot
  use_existing = true
}
## azuread_service_principal.copilot_m365.client_id

resource "azuread_service_principal" "copilot_security" {
  client_id    = "bb5ffd56-39eb-458c-a53a-775ba21277da" ## Microsoft Security Copilot
  use_existing = true
}
## azuread_service_principal.copilot_security.client_id

resource "azuread_service_principal" "device_management" {
  client_id    = "de50c81f-5f80-4771-b66b-cebd28ccdfc1" ## Device Management Client (Intune/Autopilot)
  use_existing = true
}
## azuread_service_principal.device_management.client_id

resource "azuread_service_principal" "power_platform_api" {
  client_id    = "8578e004-a5c6-46e7-913e-12f58912df43" // Power Platform API
  use_existing = true
}
## azuread_service_principal.power_platform_api.client_id

resource "azuread_service_principal" "powerapps_service" {
  client_id    = "475226c6-020e-4fb2-8a90-7a972cbfc1d4" // Power Apps Service
  use_existing = true
}
## azuread_service_principal.powerapps_service.client_id

resource "azuread_service_principal" "dynamics_service" {
  client_id    = "00000007-0000-0000-c000-000000000000" // Dynamics CRM
  use_existing = true
}
## azuread_service_principal.dynamics_service.client_id

resource "azuread_service_principal" "intune_provisioning_client" {
  client_id    = "f1346770-5b25-470b-88bd-d5744ab7952c" // Intune Provisioning client
  use_existing = true
}
## azuread_service_principal.intune_provisioning_client.client_id

resource "azuread_service_principal" "azure_powershell" {
  client_id    = "1950a258-227b-4e31-a9cf-717495945fc2" // Azure PowerShell
  use_existing = true
}
## azuread_service_principal.azure_powershell.client_id

resource "azuread_service_principal" "microsoft_graph_cli" {
  client_id    = "14d82eec-204b-4c2f-b7e8-296a70dab67e" // Microsoft Graph Command Line Tools
  use_existing = true
}
## azuread_service_principal.azure_powershell.client_id