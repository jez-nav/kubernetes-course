# modules/eks/main.tf
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0" # Pin version within the module

  cluster_name    = var.cluster_name # Use module variable
  cluster_version = var.cluster_version # Use module variable

  vpc_id     = var.vpc_id     # Use module variable
  subnet_ids = var.subnet_ids # Use module variable

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
  }

  eks_managed_node_groups = {
    default_nodes = { # Renamed for clarity within module
      name           = "${var.cluster_name}-nodes"
      instance_types = var.instance_types # Use module variable
      min_size       = var.min_size       # Use module variable
      max_size       = var.max_size       # Use module variable
      desired_size   = var.desired_size   # Use module variable
    }
  }
  tags = var.tags # Use module variable
  # Add aws_auth_users config here if needed, referencing module variables
}
