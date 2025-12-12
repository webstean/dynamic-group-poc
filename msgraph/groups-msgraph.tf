resource "msgraph_resource" "company_dynamic_groups" {
  for_each = local.unique_company_set

  url = "groups"
  body = {
    displayName     = "Dyn-Company-${each.value}-Members"
    description     = "Dynamic group for members with department == '${each.value}'"
    mailEnabled     = false
    mailNickname    = "dyn-company" ## required even when mail is disabled
    securityEnabled = true
    "owners@odata.bind" = [
      "https://graph.microsoft.com/v1.0/servicePrincipals/${data.azurerm_client_config.current.object_id}",
      "https://graph.microsoft.com/v1.0/servicePrincipals/c5393580-f805-4401-95e8-94b7a6ef2fc2",
    ]
    groupTypes = ["DynamicMembership"]
    membershipRule = <<RULE
(user.accountEnabled -eq true) and (user.userType -eq "Member") and (user.companyName -eq "${each.value}")
RULE
    membershipRuleProcessingState = "On"
  }
}

resource "msgraph_resource" "department_dynamic_groups" {
  for_each = local.unique_department_set

  url = "groups"
  body = {
    displayName     = "Dyn-Department-${each.value}-Members"
    description     = "Dynamic group for members with companyName == '${each.value}'"
    mailEnabled     = false
    mailNickname    = "dyn-department" ## required even when mail is disabled
    securityEnabled = true
    "owners@odata.bind" = [
      "https://graph.microsoft.com/v1.0/servicePrincipals/${data.azurerm_client_config.current.object_id}",
      "https://graph.microsoft.com/v1.0/servicePrincipals/c5393580-f805-4401-95e8-94b7a6ef2fc2",
    ]
    groupTypes = ["DynamicMembership"]
    membershipRule = <<RULE
(user.accountEnabled -eq true) and (user.userType -eq "Member") and (user.department -eq "${each.value}")
RULE
    membershipRuleProcessingState = "On"
  }
}

resource "msgraph_resource" "exta5_dynamic_groups" {
  for_each = local.unique_extension_attribute5_set

  url = "groups"
  body = {
    displayName     = "Dyn-Group-${each.value}-Members"
    description     = "Dynamic group for enable members accounts with extensionAttribute5 == '${each.value}'"
    mailEnabled     = false
    mailNickname    = "dyn-exta5" ## required even when mail is disabled
    securityEnabled = true
    "owners@odata.bind" = [
      "https://graph.microsoft.com/v1.0/servicePrincipals/${data.azurerm_client_config.current.object_id}",
      "https://graph.microsoft.com/v1.0/servicePrincipals/c5393580-f805-4401-95e8-94b7a6ef2fc2",
    ]
    groupTypes = ["DynamicMembership"]
    membershipRule = <<RULE
(user.accountEnabled -eq true) and (user.userType -eq "Member") and (user.extensionAttribute5 -eq "${each.value}")
RULE
    membershipRuleProcessingState = "On"
  }
}

resource "msgraph_resource" "exta6_dynamic_groups" {
  for_each = local.unique_extension_attribute6_set

  url = "groups"
  body = {
    displayName     = "Dyn-Group-${each.value}-Members"
    description     = "Dynamic group for enable members accounts with extensionAttribute6 == '${each.value}'"
    mailEnabled     = false
    mailNickname    = "dyn-exta6" ## required even when mail is disabled
    securityEnabled = true
    "owners@odata.bind" = [
      "https://graph.microsoft.com/v1.0/servicePrincipals/${data.azurerm_client_config.current.object_id}",
      "https://graph.microsoft.com/v1.0/servicePrincipals/c5393580-f805-4401-95e8-94b7a6ef2fc2",
    ]
    groupTypes = ["DynamicMembership"]
    membershipRule = <<RULE
(user.accountEnabled -eq true) and (user.userType -eq "Member") and (user.extensionAttribute6 -eq "${each.value}")
RULE
    membershipRuleProcessingState = "On"
  }
}

resource "msgraph_resource" "exta7_dynamic_groups" {
  for_each = local.unique_extension_attribute7_set

  url = "groups"
  body = {
    displayName     = "Dyn-Group-${each.value}-Members"
    description     = "Dynamic group for enable members accounts with extensionAttribute7 == '${each.value}'"
    mailEnabled     = false
    mailNickname    = "dyn-exta7" ## required even when mail is disabled
    securityEnabled = true
    "owners@odata.bind" = [
      "https://graph.microsoft.com/v1.0/servicePrincipals/${data.azurerm_client_config.current.object_id}",
      "https://graph.microsoft.com/v1.0/servicePrincipals/c5393580-f805-4401-95e8-94b7a6ef2fc2",
    ]
    groupTypes = ["DynamicMembership"]
    membershipRule = <<RULE
(user.accountEnabled -eq true) and (user.userType -eq "Member") and (user.extensionAttribute7 -eq "${each.value}")
RULE
    membershipRuleProcessingState = "On"
  }
}

