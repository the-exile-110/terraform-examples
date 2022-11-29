locals {
  config_yaml_files = fileset("./_env", "/*.yml")
  merged_configs    = [for file in local.config_yaml_files : yamldecode(file("./_env/${file}"))]
  env_vars          = merge(local.merged_configs...)

  env_name     = local.env_vars.env
  default_tags = merge(local.env_vars.default_tags, {
    Environment = local.env_vars.env
  })
}

terraform {
  extra_arguments "aws_profile" {
    commands = ["init", "apply", "refresh", "import", "plan", "taint", "untaint"]
    env_vars = {
      AWS_PROFILE = local.env_vars.aws_profile
    }
  }
}

remote_state {
  backend = "s3"
  config  = {
    profile = local.env_vars.remote_state_aws_profile
    bucket  = local.env_vars.remote_state_bucket
    key     = "${local.env_name}/${path_relative_to_include()}.tfstate"
    region  = local.env_vars.region
    encrypt = true
  }
}

generate "provider" {
  path      = "_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "aws" {
      profile = "${local.env_vars.aws_profile}"
      region = "${local.env_vars.region}"
      default_tags {
        tags = {
          Environment = "${local.env_name}"
        }
      }
    }
  EOF
}

generate "version" {
  path      = "_version.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_version = "1.3.0"
      backend "s3" {}

      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 4.27.0"
        }
      }
    }
  EOF
}
