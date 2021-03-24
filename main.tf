terraform {
}

# https://www.terraform.io/docs/providers/aws/r/inspector_assessment_target.html
resource "aws_inspector_assessment_target" "myinspector" {
  name = "inspector-instance-assessment"
}

resource "aws_inspector_assessment_template" "template" {
  name       = data.aws_region.current.name
  target_arn = aws_inspector_assessment_target.myinspector.arn
  duration   = 3600

  # https://docs.aws.amazon.com/inspector/latest/userguide/inspector_rules-arns.html
  rules_package_arns = [
    var.network_reachability_arn[data.aws_region.current.name]
  ]
  tags = var.tags
}
