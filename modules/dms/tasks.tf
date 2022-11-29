resource "aws_dms_replication_task" "mongodb_to_dynamodb_full_load_task" {
  replication_task_id       = var.mongodb_to_dynamodb_full_load_task.replication_task_id
  migration_type            = var.mongodb_to_dynamodb_full_load_task.migration_type
  replication_instance_arn  = aws_dms_replication_instance.test.replication_instance_arn
  source_endpoint_arn       = aws_dms_endpoint.source_mongodb.endpoint_arn
  target_endpoint_arn       = aws_dms_endpoint.target_dynamodb.endpoint_arn
  table_mappings            = file(var.mongodb_to_dynamodb_full_load_task.table_mappings)
  replication_task_settings = file(var.mongodb_to_dynamodb_full_load_task.replication_task_settings)
  tags                      = var.mongodb_to_dynamodb_full_load_task.tags
}