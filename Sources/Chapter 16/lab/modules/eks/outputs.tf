# modules/eks/outputs.tf
output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name # Reference internal module block
}
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}
output "cluster_certificate_authority_data" {
  description = "Base64 encoded cluster certificate authority data"
  value       = module.eks.cluster_certificate_authority_data
}
output "cluster_region" {
  description = "AWS Region for the cluster"
  # Note: The EKS module itself doesn't directly output the region easily
  # It's better practice to pass the region *into* the module if needed,
  # or rely on the root module's region variable.
  # For simplicity here, we might omit this or derive it differently if needed.
  # Check module docs if this output exists (it might be under cluster_primary_security_group_id or similar indirect attribute)
  # value = module.eks.cluster_region # This specific output might not exist directly
  # Placeholder - assuming region is passed in or known at root level
  value = "Region-Not-Directly-Output-By-Module"
}
# Add other outputs like security group ID if needed
output "cluster_primary_security_group_id" {
  description = "Cluster security group ID"
  value       = module.eks.cluster_primary_security_group_id
}
