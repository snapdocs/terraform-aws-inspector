
# AWS Inspector v2 Configuration
variable "account_ids" {
  description = "List of AWS account IDs to enable Inspector v2 for"
  type        = list(string)
  default     = []
}

variable "resource_types" {
  description = "List of resource types to enable Inspector v2 scanning for"
  type        = list(string)
  default     = ["ECR", "EC2", "LAMBDA", "LAMBDA_CODE"]
}

# Delegated Admin Configuration
variable "is_delegated_admin" {
  description = "Whether this account should be configured as the delegated admin account"
  type        = bool
  default     = false
}

variable "member_account_ids" {
  description = "List of member account IDs to associate (only used by delegated admin account)"
  type        = list(string)
  default     = []
}

# Organization Auto-Enable Configuration
variable "auto_enable_ec2" {
  description = "Automatically enable Inspector v2 for EC2 instances in new accounts"
  type        = bool
  default     = true
}

variable "auto_enable_ecr" {
  description = "Automatically enable Inspector v2 for ECR repositories in new accounts"
  type        = bool
  default     = true
}

variable "auto_enable_lambda" {
  description = "Automatically enable Inspector v2 for Lambda functions in new accounts"
  type        = bool
  default     = true
}


variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
