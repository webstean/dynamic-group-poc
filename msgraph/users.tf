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
  # Query output into local variable
  members = [
    for u in data.msgraph_resource.users : u
    ## if lower(try(u.all.user_type, "")) == "member"
  ]

  # 1. Extract Attributes
  company_raw = [
    for u in local.members :
    u.all.companyName
    if try(u.all.companyName, null) != null
  ]
  department_raw = [
    for u in local.members :
    u.all.department
    if try(u.all.department, null) != null
  ]
  extension_attribute5_raw = [
    for u in local.members :
    u.all.onPremisesExtensionAttributes.extension_attributes.extension_attribute5
    if try(u.all.onPremisesExtensionAttributes.extension_attributes.extension_attribute5, null) != null
  ]
  extension_attribute6_raw = [
    for u in local.members :
    u.all.onPremisesExtensionAttributes.extension_attributes.extension_attribute6
    if try(u.all.onPremisesExtensionAttributes.extension_attributes.extension_attribute6, null) != null
  ]
  extension_attribute7_raw = [
    for u in local.members :
    u.all.onPremisesExtensionAttributes.extension_attributes.extension_attribute7
    if try(u.all.onPremisesExtensionAttributes.extension_attributes.extension_attribute7, null) != null
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
  unique_company_set = sort(distinct(local.unique_company))
  unique_department_set = sort(distinct(local.unique_department))
  unique_extension_attribute5_set = toset(local.unique_extension_attribute5)
  unique_extension_attribute6_set = toset(local.unique_extension_attribute6)
  unique_extension_attribute7_set = toset(local.unique_extension_attribute7)
}

output "members" {
  value = local.members
}

output "list_company" {
  description = "List of all unique Company Names in the Entra ID Tenacy from all enabled member accounts"
  value = local.unique_company_set
}
output "list_departmemt" {
  description = "List of all unique Department names in the Entra ID Tenacy from all enabled member accounts"
  value = local.unique_department_set
}
output "list_company_name" {
  description = "List of all unique Company Names in the Entra ID Tenacy from all enabled member accounts"
  value = local.unique_company_set
}
output "list_extended_attribute_5" {
  description = "List of all unique extensionAttribute5 in the Entra ID Tenacy from all enabled member accounts"
  value = local.unique_extension_attribute5_set 
}
output "list_extended_attribute_6" {
  description = "List of all unique extensionAttribute6 in the Entra ID Tenacy from all enabled member accounts"
  value = local.unique_extension_attribute6_set 
}
output "list_extended_attribute_7" {
  description = "List of all unique extensionAttribute7 in the Entra ID Tenacy from all enabled member accounts"
  value = local.unique_extension_attribute7_set 
}

