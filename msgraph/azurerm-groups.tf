/*
resource "azuread_group_without_members" "company_dynamic_groups" {
  for_each = local.unique_company_set

  display_name     = "Dyn-Company-${each.value}-Members"
  description      = "Dynamic group for members with companyName == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    # - Only Members, No Guests, Account Enabled
    rule = "( (user.accountEnabled -eq true) and (user.userType -eq \"Member\") and (user.companyName -eq \"${each.value}\"))"
  }
}

resource "azuread_group_without_members" "department_dynamic_groups" {
  for_each = local.unique_department_set

  display_name     = "Dyn-Departmnet-${each.value}-Members"
  description      = "Dynamic group for members with department == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    # - Only Members, No Guests, Account Enabled
    rule = "( (user.accountEnabled -eq true) and (user.userType -eq \"Member\") and (user.department -eq \"${each.value}\"))"
  }
}

resource "azuread_group_without_members" "exta5_dynamic_groups" {
  for_each = local.unique_extension_attribute5_set

  display_name     = "Dyn-Group-${each.value}-Members"
  description      = "Dynamic group for enable members account with extensionAttribute5 == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    # - Only Members, No Guests, Account Enabled
    rule = "( (user.accountEnabled -eq true) and (user.userType -eq \"Member\") and (user.extensionAttribute5 -eq \"${each.value}\"))"
  }
}

resource "azuread_group_without_members" "exta6_dynamic_groups" {
  for_each = local.unique_extension_attribute6_set

  display_name     = "Dyn-Division-${each.value}-Members"
  description      = "Dynamic group for enable members account with extensionAttribute6 == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    # - Only Members, No Guests, Account Enabled
    rule = "( (user.accountEnabled -eq true) and (user.userType -eq \"Member\") and (user.extensionAttribute6 -eq \"${each.value}\"))"
  }
}

resource "azuread_group_without_members" "exta7_dynamic_groups" {
  for_each = local.unique_extension_attribute7_set

  display_name     = "Dyn-Branch-${each.value}-Members"
  description      = "Dynamic group for enable members account with extensionAttribute7 == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    # - Only Members, No Guests, Account Enabled
    rule = "( (user.accountEnabled -eq true) and (user.userType -eq \"Member\") and (user.extensionAttribute7 -eq \"${each.value}\"))"
  }
}
*/
