resource "msgraph_resource" "group" {
  url = "groups"
  body = {
    displayName     = "My Test xGroup"
    mailEnabled     = false
    mailNickname    = "mygroup"
    securityEnabled = true
  }
}
