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

variable "cidr_block" {
  type = string
}

variable "enable_nat_gateway" {
  type = bool
}

variable "single_nat_gateway" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "enable_flow_log" {
  type = bool
}

variable "create_flow_log_cloudwatch_iam_role" {
  type = bool
}

variable "create_flow_log_cloudwatch_log_group" {
  type = bool
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "cluster_name" {
  type = string
}