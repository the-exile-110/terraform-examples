resource "aws_dms_endpoint" "source_mongodb" {
  database_name               = var.source_mongodb.database_name
  endpoint_id                 = var.source_mongodb.endpoint_id
  endpoint_type               = var.source_mongodb.endpoint_type
  engine_name                 = var.source_mongodb.engine_name
  extra_connection_attributes = var.source_mongodb.extra_connection_attributes
  kms_key_arn                 = var.source_mongodb.kms_key_arn
  username                    = var.source_mongodb.username
  password                    = var.source_mongodb.password
  port                        = var.source_mongodb.port
  server_name                 = var.source_mongodb.server_name
  ssl_mode                    = var.source_mongodb.ssl_mode
  mongodb_settings {
    auth_type           = var.source_mongodb.mongodb_settings.auth_type
    auth_mechanism      = var.source_mongodb.mongodb_settings.auth_mechanism
    nesting_level       = var.source_mongodb.mongodb_settings.nesting_level
    extract_doc_id      = var.source_mongodb.mongodb_settings.extract_doc_id
    docs_to_investigate = var.source_mongodb.mongodb_settings.docs_to_investigate
    auth_source         = var.source_mongodb.mongodb_settings.auth_source
  }
  tags = var.source_mongodb.tags
}

resource "aws_dms_endpoint" "source_aurora" {
  database_name               = var.source_aurora.database_name
  endpoint_id                 = var.source_aurora.endpoint_id
  endpoint_type               = var.source_aurora.endpoint_type
  engine_name                 = var.source_aurora.engine_name
  extra_connection_attributes = var.source_aurora.extra_connection_attributes
  kms_key_arn                 = var.source_aurora.kms_key_arn
  username                    = var.source_aurora.username
  password                    = var.source_aurora.password
  port                        = var.source_aurora.port
  server_name                 = var.source_aurora.server_name
  ssl_mode                    = var.source_aurora.ssl_mode
  tags = var.source_aurora.tags
}
