terraform {
  source = "../../../modules/vpc"
}

prevent_destroy = false

include "root" {
  path   = find_in_parent_folders("terragrunt.hcl")
  expose = true
}

inputs = {
  aws_account_id                       = include.root.locals.env_vars.aws_account_id
  aws_region                           = include.root.locals.env_vars.aws_region
  env                                  = include.root.locals.env_vars.env
  prefix_env                           = include.root.locals.env_vars.prefix_env
  cidr_block                           = include.root.locals.env_vars.vpc.cidr_block
  private_subnets                      = include.root.locals.env_vars.vpc.private_subnets
  public_subnets                       = include.root.locals.env_vars.vpc.public_subnets
  enable_nat_gateway                   = include.root.locals.env_vars.vpc.enable_nat_gateway
  single_nat_gateway                   = include.root.locals.env_vars.vpc.single_nat_gateway
  enable_dns_hostnames                 = include.root.locals.env_vars.vpc.enable_dns_hostnames
  enable_flow_log                      = include.root.locals.env_vars.vpc.enable_flow_log
  create_flow_log_cloudwatch_iam_role  = include.root.locals.env_vars.vpc.create_flow_log_cloudwatch_iam_role
  create_flow_log_cloudwatch_log_group = include.root.locals.env_vars.vpc.create_flow_log_cloudwatch_log_group
  cluster_name                         = include.root.locals.env_vars.eks.cluster_name
}
