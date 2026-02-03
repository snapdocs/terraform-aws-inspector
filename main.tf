terraform {
}

# Designate this account as the delegated admin (only for admin account)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_delegated_admin_account
resource "aws_inspector2_delegated_admin_account" "admin" {
  count      = var.is_delegated_admin ? 1 : 0
  account_id = data.aws_caller_identity.current.account_id
}

# Organization configuration (only for admin account)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_organization_configuration
resource "aws_inspector2_organization_configuration" "org_config" {
  count = var.is_delegated_admin ? 1 : 0
  
  auto_enable {
    ec2         = var.auto_enable_ec2
    ecr         = var.auto_enable_ecr
    lambda      = var.auto_enable_lambda
    lambda_code = var.auto_enable_lambda_code
  }

  depends_on = [aws_inspector2_delegated_admin_account.admin]
}

# AWS Inspector v2 Enabler
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_enabler
resource "aws_inspector2_enabler" "inspector" {
  account_ids    = var.account_ids
  resource_types = var.resource_types

  # Only depend on admin designation when it exists (delegated admin accounts)
  # Organization configuration is not required for enablement
  depends_on = var.is_delegated_admin ? [aws_inspector2_delegated_admin_account.admin] : []
}

# Member account association (only for admin account managing member accounts)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_member_association
resource "aws_inspector2_member_association" "members" {
  for_each   = var.is_delegated_admin ? toset(var.member_account_ids) : []
  account_id = each.value

  depends_on = [aws_inspector2_enabler.inspector]
}
