resource "msgraph_resource" "group" {
  url = "groups"
  body = {
    displayName     = "My Test Group"
    mailEnabled     = false
    mailNickname    = "mygroupxy"
    securityEnabled = true
  }
}
