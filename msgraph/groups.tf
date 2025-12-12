resource "msgraph_resource" "group" {
  url = "groups"
  body = {
    displayName     = "My Test xGroup"
    mailEnabled     = false
    mailNickname    = "mygroup"
    securityEnabled = true
  }
}

resource "azuread_group_without_members" "company_dynamic_groups" {
  for_each = local.unique_company_set

  display_name     = "xDyn-Company-${each.value}-Members"
  description      = "Dynamic group for members with companyName == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    #  - Only Members, No Guests (double check)
    rule = "((user.userType -eq \"Member\") and (user.company -eq \"${each.value}\"))"
  }
}

resource "azuread_group_without_members" "department_dynamic_groups" {
  for_each = local.unique_department_set

  display_name     = "xDyn-Departmnet-${each.value}-Members"
  description      = "Dynamic group for members with department == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    #  - Only Members, No Guests (double check)
    rule = "((user.userType -eq \"Member\") and (user.department -eq \"${each.value}\"))"
  }
}

resource "azuread_group_without_members" "exta5_dynamic_groups" {
  for_each = local.unique_extension_attribute5_set

  display_name     = "xDyn-Group-${each.value}-Members"
  description      = "Dynamic group for enable members account with extensionAttribute5 == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    #  - Only Members, No Guests (double check)
    rule = "((user.userType -eq \"Member\") and (user.extensionAttribute5 -eq \"${each.value}\"))"
  }
}

resource "azuread_group_without_members" "exta6_dynamic_groups" {
  for_each = local.unique_extension_attribute6_set

  display_name     = "xDyn-Division-${each.value}-Members"
  description      = "Dynamic group for enable members account with extensionAttribute6 == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    #  - Only Members, No Guests (double check)
    rule = "((user.userType -eq \"Member\") and (user.extensionAttribute6 -eq \"${each.value}\"))"
  }
}

resource "azuread_group_without_members" "exta7_dynamic_groups" {
  for_each = local.unique_extension_attribute7_set

  display_name     = "xDyn-Branch-${each.value}-Members"
  description      = "Dynamic group for enable members account with extensionAttribute7 == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    #  - Only Members, No Guests (double check)
    rule = "((user.userType -eq \"Member\") and (user.extensionAttribute7 -eq \"${each.value}\"))"
  }
}
