data "msgraph_resource" "users" {
  url = "users"
  query_parameters = {
    "$select" = ["givenName", "surname", "department", "companyName", "onPremisesExtensionAttributes"]
    "$filter" = [
       "accountEnabled eq true and userType eq 'Member'",
    ]
  }

  response_export_values = {
    all          = "@"
  }
}

locals {
  # Cleanup query output and put into a local variable
  members = try(
    flatten([
      for item in data.msgraph_resource.users :
      item.all.value
      if can(item.all.value)
    ]),
    []
  )

  # 1. Extract desired attributes into new local variables
  company_raw = [
    for u in local.members :
    u.companyName
    if try(u.companyName, null) != null
  ]
  department_raw = [
    for u in local.members :
    u.department
    if try(u.department, null) != null
  ]
  extension_attribute5_raw = [
    for u in local.members :
    u.onPremisesExtensionAttributes.extension_attribute5
    if try(u.onPremisesExtensionAttributes.extension_attribute5, null) != null
  ]
  extension_attribute6_raw = [
    for u in local.members :
    u.onPremisesExtensionAttributes.extension_attribute6
    if try(u.onPremisesExtensionAttributes.extension_attribute6, null) != null
  ]
  extension_attribute7_raw = [
    for u in local.members :
    u.onPremisesExtensionAttributes.extension_attribute7
    if try(u.onPremisesExtensionAttributes.extension_attribute7, null) != null
  ]

  # 2. Remove null / empty values
  company_clean = compact(local.company_raw)
  department_clean = compact(local.department_raw)
  extension_attribute5_clean = compact(local.extension_attribute5_raw)
  extension_attribute6_clean = compact(local.extension_attribute6_raw)
  extension_attribute7_clean = compact(local.extension_attribute7_raw)

  # 3. Deduplicate and sort
  unique_company = sort(distinct(local.company_clean))
  unique_department = sort(distinct(local.department_clean))
  unique_extension_attribute5 = sort(distinct(local.extension_attribute5_clean))
  unique_extension_attribute6 = sort(distinct(local.extension_attribute6_clean))
  unique_extension_attribute7 = sort(distinct(local.extension_attribute7_clean))

  # 4. Turn the list into a set for for_each
  unique_company_set = toset(local.unique_company)
  unique_department_set = toset(local.unique_department)
  unique_extension_attribute5_set = toset(local.unique_extension_attribute5)
  unique_extension_attribute6_set = toset(local.unique_extension_attribute6)
  unique_extension_attribute7_set = toset(local.unique_extension_attribute7)
}

/*
## Debugging
output "members" {
  value = local.members
}
*/

output "list_company_names" {
  description = "List of all unique Company Names in the Entra ID Tenacy from all enabled member user accounts"
  value = local.unique_company_set
}
output "list_departmemts" {
  description = "List of all unique Department names in the Entra ID Tenacy from all enabled member user accounts"
  value = local.unique_department_set
}
output "list_extended_attribute_5" {
  description = "List of all unique extensionAttribute5 in the Entra ID Tenacy from all enabled member user accounts"
  value = local.unique_extension_attribute5_set 
}
output "list_extended_attribute_6" {
  description = "List of all unique extensionAttribute6 in the Entra ID Tenacy from all enabled member user accounts"
  value = local.unique_extension_attribute6_set 
}
output "list_extended_attribute_7" {
  description = "List of all unique extensionAttribute7 in the Entra ID Tenacy from all enabled member user accounts"
  value = local.unique_extension_attribute7_set 
}

