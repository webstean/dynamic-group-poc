data "msgraph_resource" "users" {
  url = "users"
  response_export_values = {
    all          = "@"
    display_name = "displayName"
  }
}
