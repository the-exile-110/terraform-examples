output "cluster_id" {
  description = "EKS cluster ID"
  value       = module.eks.cluster_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "aws_auth_config_map" {
  value = module.eks.aws_auth_configmap_yaml
}

output "cluster_name" {
  value = var.cluster_name
}

output "region" {
  value = var.region
}

output "aws_account_id" {
  value = var.aws_account_id
}
