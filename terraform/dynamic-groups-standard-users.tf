### Create Entra ID (Azure AD) Dynamic Groups

resource "azuread_group" "dynamic_P1_license" {
  display_name = "Dynamic-License-All-Enabled-Users-with-atleast-EntraID-P1-license"
  description  = "Users: All enabled users with atleast Entra ID P1 (E3) licensing. Note: This will include the P2 users as well"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = "user.accountEnabled -eq true -and (user.assignedPlans -any (assignedPlan.servicePlanId -eq \"41781fb2-bc02-4b7c-bd55-b576c07bb09d\" -and assignedPlan.capabilityStatus -eq \"Enabled\"))"
  }
}

resource "azuread_group" "dynamic_P2_license" {
  display_name = "Dynamic-License-All-Enabled-Users-with-atleast-EntraID-P2-license"
  description  = "Users: All enabled users with atleast Entra ID P2 (E5) licensing. Note: Most Entra ID saveguards are only available to P1 or above users"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = "user.accountEnabled -eq true -and (user.assignedPlans -any (assignedPlan.servicePlanId -eq \"eec0eb4f-6444-4f95-aba0-50c24d67f998\" -and assignedPlan.capabilityStatus -eq \"Enabled\"))"
  }
}

// Microsoft Entra Workload ID P1 (84c289f0-efcb-486f-8581-07f44fc9efad)
// Microsoft Entra Workload ID P2 (7dc0e92d-bf15-401d-907e-0884efe7c760)
resource "azuread_group" "dynamic_WP1_license" {
  display_name = "Dynamic-License-All-Enabled-Principles-with-WorkloadID-P1-license"
  description  = "Principles: All enabled principles with Microsoft Entra Workload ID P1 licensing. Note: Most Entra ID conditional access are only available to P1 or above users"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = <<RULE
user.accountEnabled -eq true -and (user.assignedPlans -any (assignedPlan.servicePlanId -eq "84c289f0-efcb-486f-8581-07f44fc9efad" -and assignedPlan.capabilityStatus -eq "Enabled"))
RULE
  }
}

resource "azuread_group" "dynamic_WP2_license" {
  display_name = "Dynamic-License-All-Enabled-Principles-with-WorkloadID-P2-license"
  description  = "Principles: All enabled principles with Microsoft Entra Workload ID P2 licensing. Note: Most Entra ID saveguards are only available to P1 or above users"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = <<RULE
user.accountEnabled -eq true -and (user.assignedPlans -any (assignedPlan.servicePlanId -eq "7dc0e92d-bf15-401d-907e-0884efe7c760" -and assignedPlan.capabilityStatus -eq "Enabled"))
RULE
  }
}

resource "azuread_group" "dynamic_dynamics_365" {
  display_name = "Dynamic-License-All-Enabled-Users-with-either-Dynamics-365-CRM-Professional-or-Enterprise-License"
  description  = "Users: All enabled users with either the Dynamics 365 Sales (CRM) Professional or Enterprise License"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = <<RULE
user.accountEnabled -eq true -and ((user.assignedPlans -any (assignedPlan.servicePlanId -eq "be9f9771-1c64-4618-9907-244325141096" -and assignedPlan.capabilityStatus -eq "Enabled")) -or (user.assignedPlans -any (assignedPlan.servicePlanId -eq "1e1a282c-9c54-43a2-9310-98ef728faace" -and assignedPlan.capabilityStatus -eq "Enabled")))
RULE
  }
}

resource "azuread_group" "dynamic_dynamics_d365_professional" {
  display_name = "Dynamic-License-All-Enabled-Users-with-Dynamics-365-CRM-Professional"
  description  = "Users: All enabled users with Dynamics 365 Sales (CRM) Professional"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = "user.accountEnabled -eq true -and (user.assignedPlans -any (assignedPlan.servicePlanId -eq \"be9f9771-1c64-4618-9907-244325141096\" -and assignedPlan.capabilityStatus -eq \"Enabled\"))"
  }
}

resource "azuread_group" "dynamic_dynamics_d365_enterprise" {
  display_name = "Dynamic-License-All-Enabled-Users-with-Dynamics-365-CRM-Enterprise"
  description  = "Users: All enabled users with Dynamics 365 Sales (CRM) Enterprise"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = "user.accountEnabled -eq true -and (user.assignedPlans -any (assignedPlan.servicePlanId -eq \"1e1a282c-9c54-43a2-9310-98ef728faace\" -and assignedPlan.capabilityStatus -eq \"Enabled\"))"
  }
}

resource "azuread_group" "dynamic_dynamic_dataverse_msteams" {
  display_name = "Dynamic-License-All-Enabled-Users-with-Dataverse-for-MS-Teams"
  description  = "Users: All enabled users with Dataverse for Microsoft Teams"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = <<RULE
user.accountEnabled -eq true -and (user.assignedPlans -any (assignedPlan.servicePlanId -eq "95b76021-6a53-4741-ab8b-1d1f3d66a95a" -and assignedPlan.capabilityStatus -eq "Enabled"))
RULE
  }
}

resource "azuread_group" "all_users" {
  display_name = "All-Users-${title(var.org_fullname)}"
  description  = "All Users including guests"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = false
  types                   = ["DynamicMembership", "Unified"]
  mail_nickname           = lower("allusers")
  mail_enabled            = true
  hide_from_address_lists = true
  assignable_to_role      = false
  theme                   = "Green"
  dynamic_membership {
    enabled = true
    rule    = <<RULE
(user.objectId -ne null) and (user.accountEnabled -eq true) and (user.userPrincipalName -notStartsWith "brk")
RULE
  }
  ## behaviors - AllowOnlyMembersToPost, HideGroupInOutlook, SubscribeMembersToCalendarEventsDisabled, SubscribeNewGroupMembers, WelcomeEmailDisabled.
  behaviors = ["HideGroupInOutlook", "SubscribeMembersToCalendarEventsDisabled", "WelcomeEmailDisabled"]
}

resource "azuread_group" "dynamic_all_guest_users" {
  display_name = "Dynamic-Users-All-Guests"
  description  = "Users: All Enabled Guest Users"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = <<RULE
(user.userType -eq "Guest") and  (user.accountEnabled -eq true)
RULE
  }
}

resource "azuread_group" "dynamic_all_users" {
  display_name = "Dynamic-Users-All"
  description  = "Users: All enabled users (members and guests)"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = <<RULE
(user.objectId -ne null) and (user.accountEnabled -eq true) and (user.userPrincipalName -notStartsWith "brk")
RULE
  }
}

resource "azuread_group" "dynamic_all_users_never_expire" {
  display_name = "Dynamic-Users-All-With-Password-Never-Expires"
  description  = "Users: All enabled users (members and guests)"
  owners = [
    data.azuread_client_config.current.object_id,
  ]
  security_enabled        = true
  types                   = ["DynamicMembership"]
  prevent_duplicate_names = local.prevent_duplicate_names

  dynamic_membership {
    enabled = true
    rule    = <<RULE
(user.objectId -ne null) and (user.accountEnabled -eq true) and (user.passwordPolicies -eq "DisablePasswordExpiration")
RULE
  }
}


