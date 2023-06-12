# Provision Azure AD Users
resource "azuread_user" "vivek" {
  user_principal_name   = "vivek@jvemuguntagmail.onmicrosoft.com"
  display_name          = "Vivek Vemugunta"
  department            = "Art"
  password              = "Super$ecret01@!"
  force_password_change = true
}


resource "azuread_user" "Bob_Ross" {
  user_principal_name   = "bobross@jvemuguntagmail.onmicrosoft.com"
  display_name          = "Bob Ross"
  department            = "Art"
  password              = "Super$ecret01@!"
  force_password_change = true
}

resource "azuread_user" "raybrown" {
  user_principal_name   = "raybrown@jvemuguntagmail.onmicrosoft.com"
  display_name          = "Ray Brown"
  department            = "Art"
  password              = "Super$ecret01@!"
  force_password_change = true
}

# Provision Azure AD Groups
data "azuread_client_config" "current" {}

resource "azuread_group" "Readers" {
  display_name = "Readers"
  #owners           = [azuread_user.Roy_Trenneman.object_id]
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.userPrincipalName -contains \"jvemuguntagmail\""
  }
}

resource "azuread_group" "Engineering" {
  display_name     = "Engineering"
  #owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.department -eq \"Engineering\""
  }
}

resource "azuread_group" "Art" {
  display_name     = "Art"
  owners           = [azuread_user.Bob_Ross.object_id]
  security_enabled = true
  types            = ["DynamicMembership"]

  dynamic_membership {
    enabled = true
    rule    = "user.department -eq \"Art\""
  }
}
