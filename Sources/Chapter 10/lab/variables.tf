# variables.tf
variable "aws_region" {
  description = "AWS region for EKS cluster"
  type        = string
  default     = "us-west-2" # Choose a region that supports EKS
}

variable "cluster_name" {
  description = "Name for the EKS cluster and associated resources"
  type        = string
  default     = "k8s-course-eks-demo"
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.27" # Choose a supported version
}
