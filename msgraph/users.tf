data "msgraph_resource" "users" {
  url = 'users?$select=displayName,givenName,postalCode,identities,companyName'
  response_export_values = {
    all          = "@"
#    display_name = "displayName"
#    company_name = "companyName"
#    city_name = "city"
  }
}

GET https://graph.microsoft.com/v1.0/users/87d349ed-44d7-43e1-9a83-5f2406dee5bd?$select=displayName,givenName,postalCode,identities

output "display_names" {
  description = "All Display Names"
  value = data.msgraph_resource.users.output.display_name
}

output "all" {
  description = "All Users"
  value = data.msgraph_resource.users.output.all
}
