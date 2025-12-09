# 1. Get all Entra ID users
data "azuread_users" "all" {
  return_all = true
}

locals {
  # 2. Filter only Member accounts (exclude Guests)
  members = [
    for u in data.azuread_users.all.users : u
    if lower(try(u.user_type, "")) == "member"
  ]

  # 3. Extract extensionAttribute6 from Members only
  extension_attribute6_raw = [
    for u in local.members :
    try(u.extension_attributes.extension_attribute6, null)
  ]

  # 4. Remove null / empty values
  extension_attribute6_clean = compact(local.extension_attribute6_raw)

  # 5. Deduplicate and sort
  unique_extension_attribute6 = sort(distinct(local.extension_attribute6_clean))

  # Convenience: turn the list into a set for for_each
  unique_extension_attribute6_set = toset(local.unique_extension_attribute6)
}

# 6. One dynamic group per unique ExtensionAttribute6 value (members-only rule)
resource "azuread_group" "exta6_dynamic_groups" {
  for_each = local.unique_extension_attribute6_set

  display_name     = "EXTA6 - ${each.value}"
  description      = "Dynamic group for members with extensionAttribute6 == '${each.value}'"
  security_enabled = true
  mail_enabled     = false

  # Required for dynamic groups in this provider
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    #  - Only Members (exclude Guests)
    #  - With matching extensionAttribute6
    rule = "((user.userType -eq \"Member\") and (user.extensionAttribute6 -eq \"${each.value}\"))"
  }
}
