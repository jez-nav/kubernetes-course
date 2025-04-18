# variables.tf (Root)
variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-west-2"
}
variable "cluster_name_prefix" {
  description = "Prefix for naming resources (VPC, EKS cluster)"
  type        = string
  default     = "k8s-course-refactored"
}
# Add variables for different environments if desired (e.g., instance_type_dev, instance_type_prod)
