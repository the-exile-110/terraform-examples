terraform {
  source = "../../../modules/dms"
}

prevent_destroy = false

include "root" {
  path   = find_in_parent_folders("terragrunt.hcl")
  expose = true
}

dependencies {
  paths = [
    "../vpc"
  ]
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id          = "vpc-12345678"
    public_subnets  = ["subnet-12345678", "subnet-12345678", "subnet-12345678"]
    private_subnets = ["subnet-12345678", "subnet-12345678", "subnet-12345678"]
    intra_subnets   = ["subnet-12345678", "subnet-12345678", "subnet-12345678"]
  }
}

inputs = {
  aws_account_id = include.root.locals.env_vars.aws_account_id
  aws_region     = include.root.locals.env_vars.aws_region
  env            = include.root.locals.env_vars.env
  prefix_env     = include.root.locals.env_vars.prefix_env

  # subnet group
  repl_subnet_group_subnet_ids = dependency.vpc.outputs.public_subnets

  # instance
  repl_instance_allocated_storage            = include.root.locals.env_vars.dms.instance.repl_instance_allocated_storage
  repl_instance_auto_minor_version_upgrade   = include.root.locals.env_vars.dms.instance.repl_instance_auto_minor_version_upgrade
  repl_instance_allow_major_version_upgrade  = include.root.locals.env_vars.dms.instance.repl_instance_allow_major_version_upgrade
  repl_instance_apply_immediately            = include.root.locals.env_vars.dms.instance.repl_instance_apply_immediately
  repl_instance_engine_version               = include.root.locals.env_vars.dms.instance.repl_instance_engine_version
  repl_instance_multi_az                     = include.root.locals.env_vars.dms.instance.repl_instance_multi_az
  repl_instance_preferred_maintenance_window = include.root.locals.env_vars.dms.instance.repl_instance_preferred_maintenance_window
  repl_instance_publicly_accessible          = include.root.locals.env_vars.dms.instance.repl_instance_publicly_accessible
  repl_instance_class                        = include.root.locals.env_vars.dms.instance.repl_instance_class
  repl_instance_id                           = include.root.locals.env_vars.dms.instance.repl_instance_id
  repl_instance_vpc_security_group_ids       = []
  repl_tags                                  = include.root.locals.env_vars.dms.instance.repl_tags
  source_mongodb                             = include.root.locals.env_vars.dms.endpoints.source_mongodb
  source_aurora                              = include.root.locals.env_vars.dms.endpoints.source_aurora
  target_dynamodb                            = include.root.locals.env_vars.dms.endpoints.target_dynamodb
  mongodb_to_dynamodb_full_load_task         = include.root.locals.env_vars.dms.replication_tasks.mongodb_to_dynamodb_full_load_task
}
