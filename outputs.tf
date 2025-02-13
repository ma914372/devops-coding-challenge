output "cluster_name" {
  description = "AWS EKS Cluster Name"
  value = module.eks.cluster_name
}
output "cluster_endpoint" {
  description = "Endpoint for AWS EKS"
  value = module.eks.cluster_endpoint
}

output "region" {
  description = "EKS Cluster Region"
  value = var.region
}

output "cluster_security_group_id" {
  description = "Security Group ID for AWS EKS Cluster"
  value = module.eks.cluster_security_group_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "kubeconfig_command" {
  description = "Command to configure kubectl"
  value       = "aws eks update-kubeconfig --region ${var.region} --name ${module.eks.cluster_name}"
}



