# locals (Local values derived from VPC CIDR)
locals {
    public_subnet_cidr_web    = cidrsubnet(var.vpc_cidr, 8, 0)
    private_subnet_cidr_app   = cidrsubnet(var.vpc_cidr, 8, 1) 
    private_subnet_cidr_db    = cidrsubnet(var.vpc_cidr, 8, 2)
    private_subnet_cidr_db_b  = cidrsubnet(var.vpc_cidr, 8, 3)
}

# VPC
resource "aws_vpc" "main_vpc" {
    cidr_block              = var.vpc_cidr
    enable_dns_support      = true      # Enable DNS resolution inside the VPC
    enable_dns_hostnames    = true      # Enable DNS hostnames for AWS resources

    tags = {
        Name = "3-tier-vpc"
    }
}

# PUBLIC SUBNET FOR WEB (FRONTEND)
resource "aws_subnet" "public_subnet_web" {
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = local.public_subnet_cidr_web
    availability_zone       = var.az
    map_public_ip_on_launch = true      # Auto-assign public IPs to EC2 instances in this subnet

    tags = {
        Name = "3-tier-public-subnet-web"
    }
}

# PRIVATE SUBNET FOR APP (BACKEND)
resource "aws_subnet" "private_subnet_app" {
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = local.private_subnet_cidr_app
    availability_zone       = var.az

    tags = {
        Name = "3-tier-private-subnet-app"
    }
}

# PRIVATE SUBNET FOR DATABASE (BACKEND-AZ-A)
resource "aws_subnet" "private_subnet_db" {
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = local.private_subnet_cidr_db
    availability_zone       = var.az

    tags = {
        Name = "3-tier-private-subnet-db"
    }
}

# SECOND SUBNET FOR DATABASE IN ANOTHER AZ (AZ-B)
resource "aws_subnet" "private_subnet_db_b" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = local.private_subnet_cidr_db_b
  availability_zone       = var.az_b
  map_public_ip_on_launch = false

  tags = {
    Name = "3-tier-private-subnet-db-b"
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = "3-tier-vpc-igw"
    }
}

# PUBLIC ROUTE TABLE
resource "aws_route_table" "public_route_table" {
    vpc_id          = aws_vpc.main_vpc.id

    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.igw.id
    }
}

# PUBLIC ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "public_route_table_association" {
    subnet_id           = aws_subnet.public_subnet_web.id
    route_table_id      = aws_route_table.public_route_table.id
}

# ELASTIC IP FOR NAT GATEWAY
resource "aws_eip" "nat_eip" {
    domain = "vpc"

    tags = {
        Name = "3-tier-elastic-ip"
    }
}

# NAT GATEWAY
resource "aws_nat_gateway" "nat_gateway" {
    subnet_id       = aws_subnet.public_subnet_web.id
    allocation_id   = aws_eip.nat_eip.id

    tags = {
        Name = "3-tier-nat-gateway"
    }
}

# PRIVATE ROUTE TABLE
resource "aws_route_table" "private_route_table" {
    vpc_id          = aws_vpc.main_vpc.id

    route {
        cidr_block      = "0.0.0.0/0"
        nat_gateway_id  = aws_nat_gateway.nat_gateway.id
    }
}

# PRIVATE ROUTE TABLE ASSOCIATION (APP)
resource "aws_route_table_association" "private_route_table_association_app" {
    subnet_id       = aws_subnet.private_subnet_app.id
    route_table_id  = aws_route_table.private_route_table.id
}

#PRIVATE ROUTE TABLE ASSOCIATION (DB)
resource "aws_route_table_association" "private_route_table_association_db" {
    subnet_id       = aws_subnet.private_subnet_db.id
    route_table_id  = aws_route_table.private_route_table.id
}

#PRIVATE ROUTE TABLE ASSOCIATION (DB-b)
resource "aws_route_table_association" "private_route_table_association_db_b" {
    subnet_id      = aws_subnet.private_subnet_db_b.id
    route_table_id  = aws_route_table.private_route_table.id
}
