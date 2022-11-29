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

# VPC
variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "intra_subnets" {
  type = list(string)
}

# EKS
variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "cluster_endpoint_private_access" {
  type = bool
}

variable "cluster_endpoint_public_access" {
  type = bool
}

variable "k8s_provider_api_version" {
  type = string
}

# EKS KMS
variable "create_kms_key" {
  type = bool
}

variable "kms_key_deletion_window_in_days" {
  type = number
}

variable "enable_kms_key_rotation" {
  type = bool
}

# Managed Node Group default
variable "ami_type" {
  type = string
}

variable "attach_cluster_primary_security_group" {
  type = bool
}

variable "create_security_group" {
  type = bool
}

# Managed Node Group

variable "capacity_type" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_size" {
  type = number
}

variable "pre_bootstrap_user_data" {
  type = string
}

# AWS Auth
variable "aws_auth_accounts" {
  default = []
  type    = list(string)
}

variable "aws_auth_users" {
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
}

variable "aws_auth_roles" {
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
}