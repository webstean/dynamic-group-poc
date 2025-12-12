data "msgraph_resource" "users" {
  url = "users"
  response_export_values = {
    all          = "@"
    display_name = "displayName"
  }
}

output "display_name" {
  value = data.msgraph_resource.users.output.display_name
}

output "all" {
  value = data.msgraph_resource.users.output.all
}
