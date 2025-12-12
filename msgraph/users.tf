data "msgraph_resource" "users" {
  url = "users"
  query_parameters = {
    "$select" = ["givenName", "surname", "companyName", "onPremisesExtensionAttributes"]
    "$filter" = [
       "accountEnabled eq true and userType eq 'Member'",
    ]
  }

  response_export_values = {
    ## all          = "@"
    "companyName" = "companyName"
    "extensionAttribute5" = "onPremisesExtensionAttributes.extensionAttribute5"
    "extensionAttribute6" = "onPremisesExtensionAttributes.extensionAttribute6"
    "extensionAttribute7" = "onPremisesExtensionAttributes.extensionAttribute7"
  }
}

locals {
  members = [
    for u in data.msgraph_resource.users : u
    ## if lower(try(u.user_type, "")) == "member"
  ]
}

/*
output "list_all_users" {
  description = "List of All Users with applicable values"
  value = local.all_users
}
*/


locals {

  # 1. Extract Attributes
  company_raw = [
    for u in local.members :
    try(u.companyName, null)
  ]
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

  # 2. Remove null / empty values
  company_clean = compact(local.company_raw)
  extension_attribute5_clean = compact(local.extension_attribute5_raw)
  extension_attribute6_clean = compact(local.extension_attribute6_raw)
  extension_attribute7_clean = compact(local.extension_attribute7_raw)

  # 3. Deduplicate and sort
  unique_commpany = sort(distinct(local.company_clean))
  unique_extension_attribute5 = sort(distinct(local.extension_attribute5_clean))
  unique_extension_attribute6 = sort(distinct(local.extension_attribute6_clean))
  unique_extension_attribute7 = sort(distinct(local.extension_attribute7_clean))

  # 6. Turn the list into a set for for_each
  unique_company_set = sort(distinct(local.unique_company))
  unique_extension_attribute5_set = toset(local.unique_extension_attribute5)
  unique_extension_attribute6_set = toset(local.unique_extension_attribute6)
  unique_extension_attribute7_set = toset(local.unique_extension_attribute7)
}

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

/*
output "all" {
  description = "All Users"
  value = data.msgraph_resource.users.output.all
}
*/
