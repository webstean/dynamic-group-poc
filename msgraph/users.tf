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
