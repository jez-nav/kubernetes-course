# main.tf

# --- VPC ---
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# --- Internet Gateway for Public Subnets ---
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# --- Public Subnets ---
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs) # Create one subnet per CIDR in the list
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)] # Distribute across AZs
  map_public_ip_on_launch = true # Instances launched here get public IPs

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
  }
}

# --- Public Route Table ---
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0" # Route traffic for the internet
    gateway_id = aws_internet_gateway.gw.id # Through the Internet Gateway
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# --- Public Route Table Associations ---
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# --- Private Subnets ---
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index + 1}"
  }
}

# --- Data source to get available AZs in the region ---
data "aws_availability_zones" "available" {}

# Note: For private subnets to reach the internet, you'd typically add a NAT Gateway
# and a private route table pointing 0.0.0.0/0 to the NAT GW. Omitted here for brevity.
