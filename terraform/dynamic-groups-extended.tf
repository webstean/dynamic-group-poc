# 1. Get all Entra ID users
data "azuread_users" "all" {
  return_all = true
}

# Output if required
output "azuread_users_display_name" {
  value = [for u in data.azuread_users.all.users : u.display_name]
}

locals {
  # 2. Filter only Member accounts (excluding Guests)
  members = [
    for u in data.azuread_users.all.users : u
    if lower(try(u.user_type, "")) == "member"
  ]

  # 3 Extract extensionAttribute from Members only
  extension_attribute5_raw = [
    for u in local.members :
    try(u.extension_attributes.extension_attribute5, null)
  ]
  extension_attribute6_raw = [
    for u in local.members :
    try(u.extension_attributes.extension_attribute6, null)
  ]
  extension_attribute7_raw = [
    for u in local.members :
    try(u.extension_attributes.extension_attribute7, null)
  ]

  # 4. Remove null / empty values
  extension_attribute5_clean = compact(local.extension_attribute5_raw)
  extension_attribute6_clean = compact(local.extension_attribute6_raw)
  extension_attribute7_clean = compact(local.extension_attribute7_raw)

  # 5. Deduplicate and sort
  unique_extension_attribute5 = sort(distinct(local.extension_attribute5_clean))
  unique_extension_attribute6 = sort(distinct(local.extension_attribute6_clean))
  unique_extension_attribute7 = sort(distinct(local.extension_attribute7_clean))

  # 6. Turn the list into a set for for_each
  unique_extension_attribute5_set = toset(local.unique_extension_attribute5)
  unique_extension_attribute6_set = toset(local.unique_extension_attribute6)
  unique_extension_attribute7_set = toset(local.unique_extension_attribute7)
}

resource "azuread_group" "exta5_dynamic_groups" {
  for_each = local.unique_extension_attribute5_set

  display_name     = "Dyn-Group-${each.value}-Members"
  description      = "Dynamic group for members with extensionAttribute5 == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    #  - Only Members, No Guests (double check)
    #  - With matching extensionAttribute5
    rule = "((user.userType -eq \"Member\") and (user.extensionAttribute5 -eq \"${each.value}\"))"
  }
}

resource "azuread_group" "exta6_dynamic_groups" {
  for_each = local.unique_extension_attribute6_set

  display_name     = "Dyn-Division-${each.value}-Members"
  description      = "Dynamic group for members with extensionAttribute6 == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    #  - Only Members, No Guests (double check)
    #  - With matching extensionAttribute6
    rule = "((user.userType -eq \"Member\") and (user.extensionAttribute6 -eq \"${each.value}\"))"
  }
}

resource "azuread_group" "exta7_dynamic_groups" {
  for_each = local.unique_extension_attribute7_set

  display_name     = "Dyn-Branch-${each.value}-Members"
  description      = "Dynamic group for members with extensionAttribute7 == '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    #  - Only Members, No Guests (double check)
    #  - With matching extensionAttribute7
    rule = "((user.userType -eq \"Member\") and (user.extensionAttribute7 -eq \"${each.value}\"))"
  }
}

output list_extension_attribute5 {
  description = "List of unique Entra ID extension attributes 5 in tenancy"
  sensitive = false
  value = local.unique_extension_attribute5_set
}
output list_extension_attribute6 {
  description = "List of unique Entra ID extension attributes 6 in tenancy"
  sensitive = false
  value = local.unique_extension_attribute6_set
}
output list_extension_attribute7 {
  description = "List of unique Entra ID extension attributes 7 in tenancy"
  sensitive = false
  value = local.unique_extension_attribute7_set
}

