data "msgraph_resource" "users" {
  url = "users"
  response_export_values = {
    all          = "@"
    display_name = "displayName"
    company_anme = "company_name"
  }
}

output "display_names" {
  description = "All Display Names"
  value = data.msgraph_resource.users.output.display_name
}

output "all" {
  description = "All Users"
  value = data.msgraph_resource.users.output.all
}
