variable "env" {
  type = string
}

variable "prefix_env" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "repl_instance_allocated_storage" {
  type = number
}

variable "repl_instance_auto_minor_version_upgrade" {
  type    = bool
  default = true
}

variable "repl_instance_allow_major_version_upgrade" {
  type    = bool
  default = true
}

variable "repl_instance_apply_immediately" {
  type    = bool
  default = true
}

variable "repl_instance_vpc_security_group_ids" {
  type = list(string)
}

variable "repl_instance_engine_version" {
  type = string
}

variable "repl_instance_multi_az" {
  type    = bool
  default = true
}

variable "repl_instance_preferred_maintenance_window" {
  type = string
}

variable "repl_instance_publicly_accessible" {
  type    = bool
  default = false
}

variable "repl_instance_class" {
  type = string
}

variable "repl_instance_id" {
  type    = string
  default = ""
}

variable "repl_subnet_group_subnet_ids" {
  type = list(string)
}

variable "repl_tags" {
  type = map(string)
}

variable "source_mongodb" {
  type = any
}

variable "source_aurora" {
  type = any
}

variable "target_dynamodb" {
  type = any
}

variable "mongodb_to_dynamodb_full_load_task" {
  type = any
}