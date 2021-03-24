
# https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html
variable "network_reachability_arn" {
  type = map(any)
  default = {
    us-east-1 = "arn:aws:inspector:us-east-1:316112463485:rulespackage/0-PmNV0Tcd"
    us-east-2 = "arn:aws:inspector:us-east-2:646659390643:rulespackage/0-cE4kTR30"
    us-west-1 = "arn:aws:inspector:us-west-1:166987590008:rulespackage/0-TxmXimXF"
    us-west-2 = "arn:aws:inspector:us-west-2:758058086616:rulespackage/0-rD1z6dpl"
  }
}
variable "tags" { default = {} }