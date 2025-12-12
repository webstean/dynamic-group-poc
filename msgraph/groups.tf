resource "msgraph_resource" "group" {
  url = "groups"
  body = {
    displayName     = "My Test xxGroup"
    mailEnabled     = false
    mailNickname    = "mygroupxy"
    securityEnabled = true
  }
}
