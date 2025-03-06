

resource "azuread_user" "envuser" {
  user_principal_name = "usr${var.env}${var.tla}@NETORGFT17726763.onmicrosoft.com"
  display_name        = "usr${var.env}${var.tla}"
  mail_nickname       = "usr${var.env}${var.tla}"
  password            = "P@ssw0rd1234!"  # Ensure you follow your organization's password policy
}

resource "azuread_group" "envcontributors" {
  display_name = "GRP-${var.env}-${var.tla}-contributors"
  mail_enabled = false
  security_enabled = true
}

resource "azuread_group_member" "envusermember" {
  group_object_id = azuread_group.envcontributors.object_id
  member_object_id = azuread_user.envuser.object_id
}