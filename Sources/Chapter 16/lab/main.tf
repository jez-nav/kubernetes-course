# main.tf (Root)

# --- VPC --- (Keep the VPC module call from Chapter 10) ---
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.cluster_name_prefix}-vpc"
  cidr = "10.0.0.0/16"
  azs  = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name_prefix}-eks" = "shared"
    "kubernetes.io/role/elb"                  = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name_prefix}-eks" = "shared"
    "kubernetes.io/role/internal-elb"         = "1"
  }
  tags = { Environment = "Development", Terraform = "true" }
}

# --- EKS Cluster (Using the local module) ---
module "eks_cluster" {
  source = "./modules/eks" # Call the local module

  # Pass values to the module's input variables
  cluster_name    = "${var.cluster_name_prefix}-eks"
  cluster_version = "1.27" # Or use a root variable
  vpc_id          = module.vpc.vpc_id # Use VPC module output
  subnet_ids      = module.vpc.private_subnets # Use VPC module output

  # Example: Override defaults for specific environment
  instance_types = ["t3.medium"] # Or use var.eks_instance_types
  desired_size   = 2             # Or use var.eks_desired_size

  tags = { Environment = "Development", Terraform = "true" }
}
