data "msgraph_resource" "users" {
  url = "users"
  query_parameters = {
    "$select" = ["givenName", "surname", "companyName", "onPremisesExtensionAttributes"]
    "$filter" = [
       "accountEnabled eq true and userType eq 'Member'",
    ]
  }

  response_export_values = {
    all          = "@"
  }
}

locals {
  all_users = [
    for u in data.msgraph_resource.users : u
    ## if lower(try(u.user_type, "")) == "member"
  ]
}

/*
locals {

  # 1. Filter only Member accounts (excluding Guests)
  members2 = [
    for u in data.azuread_users.all.users : u
    if lower(try(u.user_type, "")) == "member"
  ]
  # 3 Extract extensionAttribute
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
*/

/*
output "list_company_name" {
  description = "List of Company Name"
  value = data.msgraph_resource.users.all.companyName
}
output "list_extended_attribute_5" {
  description = "List of Extended Attribute #5"
  value = data.msgraph_resource.users.all.onPremisesExtensionAttributes.extensionAttribute5
}
output "list_extended_attribute_6" {
  description = "List of Extended Attribute #6"
  value = data.msgraph_resource.users.all.onPremisesExtensionAttributes.extensionAttribute6
}
output "list_extended_attribute_7" {
  description = "List of Extended Attribute #7"
  value = data.msgraph_resource.users.all.onPremisesExtensionAttributes.extensionAttribute7
}
*/

output "all" {
  description = "All Users"
  value = data.msgraph_resource.users.output.all
}
