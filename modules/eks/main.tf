module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.3"

  cluster_name                    = var.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  vpc_id     = var.vpc_id
  subnet_ids = var.public_subnets

  # KMS
  create_kms_key                  = var.create_kms_key
  cluster_encryption_config       = [{ resources = ["secrets"] }]
  kms_key_deletion_window_in_days = var.kms_key_deletion_window_in_days
  enable_kms_key_rotation         = var.enable_kms_key_rotation

  eks_managed_node_group_defaults = {
    ami_type                              = var.ami_type
    attach_cluster_primary_security_group = var.attach_cluster_primary_security_group
    create_security_group                 = var.create_security_group
  }

  eks_managed_node_groups = {
    one = {
      name = "${var.prefix_env}-group-1"

      instance_types = var.instance_types
      capacity_type  = var.capacity_type

      min_size     = var.min_size
      max_size     = var.max_size
      desired_size = var.desired_size

      pre_bootstrap_user_data = <<-EOT
      ${var.pre_bootstrap_user_data}
      EOT

      vpc_security_group_ids = [
        aws_security_group.node_group_one.id
      ]
    }
  }

  # addons
  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {
      resolve_conflicts = "OVERWRITE"
    }
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  # Auth
  #  manage_aws_auth_configmap = true
  #  aws_auth_users            = var.aws_auth_users
  #  aws_auth_accounts         = concat([var.aws_account_id], var.aws_auth_accounts)
  #  aws_auth_roles            = (var.aws_auth_roles == null ? [] : var.aws_auth_roles)
}

module "eks_auth" {
  depends_on = [module.eks]

  source = "aidanmelen/eks-auth/aws"
  eks    = module.eks

  map_roles    = (var.aws_auth_roles == null ? [] : var.aws_auth_roles)
  map_users    = var.aws_auth_users
  map_accounts = concat([var.aws_account_id], var.aws_auth_accounts)
}

resource "null_resource" "update_k8s_config" {
  depends_on = [module.eks, module.eks_auth]

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.cluster_name} --region ${var.aws_region}"
  }
}