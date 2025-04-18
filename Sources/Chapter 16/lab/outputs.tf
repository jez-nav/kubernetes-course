# outputs.tf (Root)
output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks_cluster.cluster_name # Reference local module output
}
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks_cluster.cluster_endpoint # Reference local module output
}
output "region" {
  description = "AWS region"
  value       = var.aws_region
}
output "configure_kubectl" {
  description = "Configure kubectl command"
  # Note: Need cluster_region output from module or use var.aws_region
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks_cluster.cluster_name}"
}
