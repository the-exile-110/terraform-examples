terraform {
  source = "../../../modules/eks"
}

prevent_destroy = false

include "root" {
  path   = find_in_parent_folders("terragrunt.hcl")
  expose = true
}

dependencies {
  paths = [
    "../vpc",
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

  # VPC
  vpc_id          = dependency.vpc.outputs.vpc_id
  public_subnets  = dependency.vpc.outputs.public_subnets
  private_subnets = dependency.vpc.outputs.private_subnets
  intra_subnets   = dependency.vpc.outputs.intra_subnets

  # EKS
  cluster_name                    = include.root.locals.env_vars.eks.cluster_name
  cluster_version                 = include.root.locals.env_vars.eks.cluster_version
  cluster_endpoint_private_access = include.root.locals.env_vars.eks.cluster_endpoint_private_access
  cluster_endpoint_public_access  = include.root.locals.env_vars.eks.cluster_endpoint_public_access
  k8s_provider_api_version        = include.root.locals.env_vars.eks.k8s_provider_api_version

  # EKS KMS
  create_kms_key                  = include.root.locals.env_vars.eks.create_kms_key
  kms_key_deletion_window_in_days = include.root.locals.env_vars.eks.kms_key_deletion_window_in_days
  enable_kms_key_rotation         = include.root.locals.env_vars.eks.enable_kms_key_rotation

  # Managed Node Group default
  ami_type                              = include.root.locals.env_vars.eks.ami_type
  attach_cluster_primary_security_group = include.root.locals.env_vars.eks.attach_cluster_primary_security_group
  create_security_group                 = include.root.locals.env_vars.eks.create_security_group

  # Managed Node Group
  capacity_type           = include.root.locals.env_vars.eks.capacity_type
  instance_types          = include.root.locals.env_vars.eks.instance_types
  min_size                = include.root.locals.env_vars.eks.min_size
  max_size                = include.root.locals.env_vars.eks.max_size
  desired_size            = include.root.locals.env_vars.eks.desired_size
  pre_bootstrap_user_data = include.root.locals.env_vars.eks.pre_bootstrap_user_data

  # AWS Auth
  aws_auth_accounts = include.root.locals.env_vars.eks.aws_auth_accounts
  aws_auth_users    = include.root.locals.env_vars.eks.aws_auth_users
  aws_auth_roles    = include.root.locals.env_vars.eks.aws_auth_roles
}