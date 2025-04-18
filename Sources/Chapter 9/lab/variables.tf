# variables.tf
variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-west-2" # Or your preferred region
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "project_name" {
  description = "Base name for resources"
  type        = string
  default     = "k8s-course-vpc"
}
