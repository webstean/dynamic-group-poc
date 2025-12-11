
locals {
  # 1. Filter only Member accounts (excluding Guests)
  members2 = [
    for u in data.azuread_users.all.users : u
    if lower(try(u.user_type, "")) == "member"
  ]

  # 2. Extract location from Members only
  attribute_test = [
    for u in local.members2 :
    try(u.usage_location, null)
  ]
}

output attribute_test {
  value = local.attribute_test
}

/*
resource "azuread_group" "user_a_dynamic_groups" {
  for_each = local.attributes_test

  display_name     = "Dyn-Users-${each.value}-Members"
  description      = "Dynamic group for members with username starting with '${each.value}'"
  security_enabled = true
  mail_enabled     = false
  types = ["DynamicMembership"]

  dynamic_membership {
    enabled = true

    # Dynamic membership rule:
    #  - Only Members, No Guests (double check)
    #  - With matching
    rule = "((user.userType -eq \"Member\") and (user.extensionAttribute6 -eq \"${each.value}\"))"
  }
}
*/
