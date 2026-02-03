# AWS Inspector v2 Outputs
output "inspector2_enabled_accounts" {
  description = "List of account IDs for which Inspector v2 has been enabled"
  value       = aws_inspector2_enabler.inspector.account_ids
}

output "inspector2_enabled_resource_types" {
  description = "List of resource types enabled for Inspector v2 scanning"
  value       = aws_inspector2_enabler.inspector.resource_types
}

output "delegated_admin_account_id" {
  description = "Account ID of the delegated admin account"
  value       = var.is_delegated_admin ? data.aws_caller_identity.current.account_id : null
}

output "member_associations" {
  description = "Map of member account associations"
  value       = { for k, v in aws_inspector2_member_association.members : k => v.account_id }
}

output "organization_auto_enable_config" {
  description = "Organization auto-enable configuration"
  value = var.is_delegated_admin ? {
    ec2         = var.auto_enable_ec2
    ecr         = var.auto_enable_ecr
    lambda      = var.auto_enable_lambda
    lambda_code = var.auto_enable_lambda_code
  } : null
}
