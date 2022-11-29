resource "aws_dms_replication_subnet_group" "dms_replication_subnet_group" {
  replication_subnet_group_id          = "${var.prefix_env}-dms-replication-subnet-group"
  replication_subnet_group_description = "DMS Replication Subnet Group"
  subnet_ids                           = var.repl_subnet_group_subnet_ids
}