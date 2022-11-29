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

variable "domain_name" {
  type = string
}

variable "validation_method" {
  type = string
}

variable "subject_alternative_names" {
  type = list(string)
}

variable "create_before_destroy" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}