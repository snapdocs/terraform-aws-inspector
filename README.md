# terraform-aws-inspector

AWS Inspector v2 Terraform module for enabling Amazon Inspector v2 across AWS accounts and resource types with full organizational support.

## Migration from Inspector v1

This module has been migrated from AWS Inspector v1 to Inspector v2. Inspector v1 is being deprecated and AWS Inspector v2 provides enhanced vulnerability management capabilities with better organizational controls.

## Usage

### Admin Account (Designated Admin - Corporate Stack)

For the designated admin account in `infosec-master-terraform`:

```hcl
module "inspector2" {
  source = "./path/to/terraform-aws-inspector"
  
  # Configure as delegated admin account
  is_delegated_admin = true
  
  # Enable for all resource types
  resource_types = ["ECR", "EC2", "LAMBDA"]
  
  # Enable for admin account and manage member accounts
  account_ids = [data.aws_caller_identity.current.account_id]
  
  # Member accounts to associate (managed by admin)
  member_account_ids = [
    "123456789012", # member account 1
    "234567890123", # member account 2
    # Add other member account IDs here
  ]
  
  # Organization auto-enable settings for new accounts
  auto_enable_ec2    = true
  auto_enable_ecr    = true
  auto_enable_lambda = true
  
  tags = {
    Environment = "production"
    Purpose     = "security-scanning"
  }
}
```

### Member Accounts (infosec-member-terraform)

For member accounts in `infosec-member-terraform`:

```hcl
module "inspector2" {
  source = "./path/to/terraform-aws-inspector"
  
  # This is not a delegated admin
  is_delegated_admin = false
  
  # Enable for all resource types
  resource_types = ["ECR", "EC2", "LAMBDA"]
  
  # Only enable for current account
  account_ids = [data.aws_caller_identity.current.account_id]
  
  tags = {
    Environment = "production"
    Purpose     = "security-scanning"
  }
}
```

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account_ids | List of AWS account IDs to enable Inspector v2 for | `list(string)` | `[]` | no |
| resource_types | List of resource types to enable Inspector v2 scanning for | `list(string)` | `["ECR", "EC2", "LAMBDA"]` | no |
| is_delegated_admin | Whether this account should be configured as the delegated admin account | `bool` | `false` | no |
| member_account_ids | List of member account IDs to associate (only used by delegated admin account) | `list(string)` | `[]` | no |
| auto_enable_ec2 | Automatically enable Inspector v2 for EC2 instances in new accounts | `bool` | `true` | no |
| auto_enable_ecr | Automatically enable Inspector v2 for ECR repositories in new accounts | `bool` | `true` | no |
| auto_enable_lambda | Automatically enable Inspector v2 for Lambda functions in new accounts | `bool` | `true` | no |
| tags | Tags to apply to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| inspector2_enabled_accounts | List of account IDs for which Inspector v2 has been enabled |
| inspector2_enabled_resource_types | List of resource types enabled for Inspector v2 scanning |
| delegated_admin_account_id | Account ID of the delegated admin account (null if not admin) |
| member_associations | Map of member account associations |
| organization_auto_enable_config | Organization auto-enable configuration (null if not admin) |

## Resource Types

The following resource types are supported by Inspector v2:

- **ECR**: Amazon Elastic Container Registry repositories
- **EC2**: Amazon EC2 instances
- **LAMBDA**: AWS Lambda functions
- **LAMBDA_CODE**: AWS Lambda function code

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 4.0 |

## Architecture

This module implements a complete Inspector v2 organizational setup:

1. **Delegated Admin Account**: Designates the corporate stack account as the Inspector v2 delegated administrator
2. **Organization Configuration**: Sets up auto-enable policies for new AWS accounts joining the organization
3. **Inspector v2 Enablement**: Enables Inspector v2 scanning across specified account IDs and resource types
4. **Member Association**: Associates member accounts with the delegated admin for centralized management

## Resources

| Name | Type |
|------|------|
| [aws_inspector2_delegated_admin_account.admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_delegated_admin_account) | resource |
| [aws_inspector2_organization_configuration.org_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_organization_configuration) | resource |
| [aws_inspector2_enabler.inspector](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_enabler) | resource |
| [aws_inspector2_member_association.members](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_member_association) | resource |

## Data Sources

| Name | Type |
|------|------|
| [data.aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [data.aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Features

- ✅ **Organizational Management**: Full support for AWS Organizations with delegated admin setup
- ✅ **Auto-Enable Policies**: Automatically enable Inspector v2 for new accounts joining the organization
- ✅ **Multi-Account Support**: Centralized management of Inspector v2 across multiple AWS accounts
- ✅ **All Resource Types**: Supports ECR, EC2, Lambda, and Lambda Code scanning
- ✅ **Member Association**: Automatic association of member accounts with the delegated admin
- 🔄 **Future Enhancement**: Inspector v2 filters for customized finding management (can be added as needed)

## References

- [AWS Inspector v2 Migration Guide](https://docs.aws.amazon.com/inspector/v1/userguide/inspector-migration.html)
- [Terraform aws_inspector2_delegated_admin_account](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_delegated_admin_account)
- [Terraform aws_inspector2_organization_configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_organization_configuration)
- [Terraform aws_inspector2_enabler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_enabler)
- [Terraform aws_inspector2_member_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_member_association)
- [Terraform aws_inspector2_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/inspector2_filter)
