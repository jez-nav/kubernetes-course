# modules/eks/variables.tf
variable "cluster_name" {
  description = "Name for the EKS cluster"
  type        = string
}
variable "cluster_version" {
  description = "Kubernetes version for EKS"
  type        = string
}
variable "vpc_id" {
  description = "ID of the VPC where the cluster runs"
  type        = string
}
variable "subnet_ids" {
  description = "List of subnet IDs for control plane and nodes"
  type        = list(string)
}
variable "instance_types" {
  description = "List of instance types for the default node group"
  type        = list(string)
  default     = ["t3.medium"]
}
variable "min_size" {
  description = "Minimum number of nodes"
  type        = number
  default     = 1
}
variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
  default     = 3
}
variable "desired_size" {
  description = "Desired number of nodes"
  type        = number
  default     = 2
}
variable "tags" {
  description = "Tags to apply to EKS resources"
  type        = map(string)
  default     = {}
}
# Add other variables as needed (e.g., for aws_auth_users)
