resource "msgraph_resource" "company_dynamic_groups" {
  for_each = local.unique_company_set

  url = "groups"
  body = {
    displayName     = "Dyn-Company-${each.value}-Members"
    description     = "Dynamic group for members with companyName == '${each.value}'"
    mailEnabled     = false
    mailNickname    = "dyn-company"
    securityEnabled = true
    "owners@odata.bind" = [
      "https://graph.microsoft.com/v1.0//servicePrincipals/${data.azurerm_client_config.current.object_id}",
    ]
    groupTypes = ["DynamicMembership"]
    membershipRule = <<RULE
( (user.accountEnabled -eq true) and (user.userType -eq "Member") and (user.companyName -eq "${each.value}") )
RULE
    membershipRuleProcessingState = "On"
  }
}
