resource "aws_dms_endpoint" "target_dynamodb" {
  endpoint_id         = var.target_dynamodb.endpoint_id
  endpoint_type       = var.target_dynamodb.endpoint_type
  engine_name         = var.target_dynamodb.engine_name
  service_access_role = aws_iam_role.dms-vpc-role.arn

  depends_on = [
    aws_iam_role.dms-vpc-role
  ]
}