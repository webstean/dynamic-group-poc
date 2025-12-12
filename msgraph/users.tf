data "msgraph_resource" "usersa" {
  url = "users"
  response_export_values = {
    all          = "@"
    display_name = "displayName"
    company_anme = "company_name"
  }
}

output "display_namea" {
  value = data.msgraph_resource.usersa.output.display_name
}

output "all" {
  value = data.msgraph_resource.usersa.output.all
}
