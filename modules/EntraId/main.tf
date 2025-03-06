

resource "azuread_group" "envcontributors" {
  display_name = "GRP-${var.env}-${var.tla}-contributors"
  mail_enabled = false
  security_enabled = true
}

resource "azuread_user" "envuser" {
  user_principal_name = "usr${var.env}${var.tla}@NETORGFT17726763.onmicrosoft.com"
  display_name        = "usr${var.env}${var.tla}"
  mail_nickname       = "usr${var.env}${var.tla}"
  password            = "P@ssw0rd1234!"  # Ensure you follow your organization's password policy
}

resource "azuread_group_member" "envusermember" {
  group_object_id = azuread_group.envcontributors.object_id
  member_object_id = azuread_user.envuser.object_id
}

#Create admin user group
resource "azuread_group" "envadmins" {
  display_name = "GRP-${var.env}-${var.tla}-admins"
  mail_enabled = false
  security_enabled = true
}
#Create admin users
resource "azuread_user" "adminuser1" {
  user_principal_name = "adminuser1${var.env}${var.tla}@NETORGFT17726763.onmicrosoft.com"
  display_name        = "adminuser1${var.env}${var.tla}"
  mail_nickname       = "adminuser1${var.env}${var.tla}"
  password            = "P@ssw0rd1234!"  # Ensure you follow your organization's password policy
}
resource "azuread_user" "adminuser2" {
  user_principal_name = "adminuser2${var.env}${var.tla}@NETORGFT17726763.onmicrosoft.com"
  display_name        = "adminuser2${var.env}${var.tla}"
  mail_nickname       = "adminuser2${var.env}${var.tla}"
  password            = "P@ssw0rd1234!"  # Ensure you follow your organization's password policy
}
#add user to group
resource "azuread_group_member" "adminuser1member" {
  group_object_id = azuread_group.envadmins.object_id
  member_object_id = azuread_user.adminuser1.object_id
}
resource "azuread_group_member" "adminuser2member" {
  group_object_id = azuread_group.envadmins.object_id
  member_object_id = azuread_user.adminuser2.object_id
}

#Create non-admin group
resource "azuread_group" "envnonadmins" {
  display_name = "GRP-${var.env}-${var.tla}-nonadmins"
  mail_enabled = false
  security_enabled = true
}

#Create non-admin users
resource "azuread_user" "nonadminuser1" {
  user_principal_name = "nonadminuser1${var.env}${var.tla}@NETORGFT17726763.onmicrosoft.com"
  display_name        = "nonadminuser1${var.env}${var.tla}"
  mail_nickname       = "nonadminuser1${var.env}${var.tla}"
  password            = "P@ssw0rd1234!"  # Ensure you follow your organization's password policy
}
resource "azuread_user" "nonadminuser2" {
  user_principal_name = "nonadminuser2${var.env}${var.tla}@NETORGFT17726763.onmicrosoft.com"
  display_name        = "nonadminuser2${var.env}${var.tla}"
  mail_nickname       = "nonadminuser2${var.env}${var.tla}"
  password            = "P@ssw0rd1234!"  # Ensure you follow your organization's password policy
}

#add non-admin users to group
resource "azuread_group_member" "nonadminuser1member" {
  group_object_id = azuread_group.envnonadmins.object_id
  member_object_id = azuread_user.nonadminuser1.object_id
}
resource "azuread_group_member" "nonadminuser2member" {
  group_object_id = azuread_group.envnonadmins.object_id
  member_object_id = azuread_user.nonadminuser2.object_id
}