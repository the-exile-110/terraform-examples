# Create a new replication instance
resource "aws_dms_replication_instance" "test" {
  replication_instance_id      = "${var.prefix_env}-dms-replication-instance"
  allocated_storage            = var.repl_instance_allocated_storage
  apply_immediately            = var.repl_instance_apply_immediately
  auto_minor_version_upgrade   = var.repl_instance_auto_minor_version_upgrade
  engine_version               = var.repl_instance_engine_version
  multi_az                     = var.repl_instance_multi_az
  preferred_maintenance_window = var.repl_instance_preferred_maintenance_window
  publicly_accessible          = var.repl_instance_publicly_accessible
  replication_instance_class   = var.repl_instance_class
  replication_subnet_group_id  = aws_dms_replication_subnet_group.dms_replication_subnet_group.id
  tags                         = var.repl_tags
  vpc_security_group_ids       = []

  depends_on = [
    aws_iam_role_policy_attachment.dms-access-for-endpoint-AmazonDMSRedshiftS3Role,
    aws_iam_role_policy_attachment.dms-cloudwatch-logs-role-AmazonDMSCloudWatchLogsRole,
    aws_iam_role_policy_attachment.dms-vpc-role-AmazonDMSVPCManagementRole
  ]
}