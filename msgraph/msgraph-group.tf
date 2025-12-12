resource "msgraph_resource" "company_dynamic_groups" {
  for_each = local.unique_company_set

  url = "groups"
  body = {
    displayName     = "Dyn-Company-${each.value}-Members"
    mailEnabled     = false
    securityEnabled = true
    groupTypes = ["DynamicMembership"]
    "owners@odata.bind" = [
      "https://graph.microsoft.com/v1.0/users/${data.azurerm_client_config.current.object_id}",
    ]
    membershipRule = "( (user.accountEnabled -eq true) and (user.userType -eq \"Member\") and (user.companyName -eq \"${each.value}\"))"
    membershipRuleProcessingState = "On"
  }
}

/*
resource "azuread_group_without_members" "company_dynamic_groups" {

  display_name     = "Dyn-Company-${each.value}-Members"
  description      = "Dynamic group for members with companyName == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  isAssignableToRole = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    # - Only Members, No Guests, Account Enabled
    rule = "( (user.accountEnabled -eq true) and (user.userType -eq \"Member\") and (user.company -eq \"${each.value}\"))"
  }
}
*/
