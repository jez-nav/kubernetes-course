# main.tf

# --- VPC ---
# Use the official VPC module to create networking resources
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0" # Use a recent compatible version

  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"] # Use 3 AZs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true # Needed for private nodes to pull images/updates
  single_nat_gateway = true # Use one NAT GW for cost savings in demo

  # Tags required by EKS
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                  = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"         = "1"
  }

  tags = {
    Environment = "Development"
    Terraform   = "true"
  }
}

# --- EKS Cluster ---
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0" # Use a recent compatible version

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets # Deploy control plane and nodes in private subnets

  # Managed Node Group Configuration
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64" # Amazon Linux 2
  }

  eks_managed_node_groups = {
    initial_nodes = {
      name           = "general-purpose-nodes"
      instance_types = ["t3.medium"] # Choose appropriate instance type
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }

  # Cluster access configuration (optional, allows your IAM user/role to administer)
  # manage_aws_auth_configmap = true # Let module manage aws-auth
  # aws_auth_users = [
  #   {
  #     userarn = "arn:aws:iam::ACCOUNT_ID:user/YOUR_IAM_USER_NAME" # Replace with your user ARN
  #     username = "YOUR_IAM_USER_NAME"
  #     groups   = ["system:masters"]
  #   }
  # ]

  tags = {
    Environment = "Development"
    Terraform   = "true"
  }
}
