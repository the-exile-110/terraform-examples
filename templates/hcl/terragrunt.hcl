prevent_destroy = false

include "root" {
  path   = find_in_parent_folders()
  expose = true
}

#dependencies {
#  paths = [
#    "../vpc",
#  ]
#}

#dependency "vpc" {
#  config_path = "../vpc"

#  mock_outputs = {
#    vpc_id = "vpc-12345678"
#  }
#}

inputs = {
  aws_region     = include.root.locals.env_vars.aws_region
  env            = include.root.locals.env_vars.env
  prefix_env     = include.root.locals.env_vars.prefix_env
  aws_account_id = include.root.locals.env_vars.aws_account_id

  // vpc_id = dependency.vpc.outputs.vpc_id
}

#generate "provider" {
#  path      = "_provider.tf"
#  if_exists = "overwrite_terragrunt"
#  contents  = <<EOF
#    provider "aws" {
#        alias                    = "us-east-1"
#        profile                  = "${include.root.locals.env_vars.aws_profile}"
#        region                   = "us-east-1"
#        shared_credentials_files = ["~/.aws/credentials"]
#    }
#  EOF
#}