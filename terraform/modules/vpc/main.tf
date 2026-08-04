# Fetch available availability zones in the region dynamically
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" {}

# 1. Custom VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
}

# 2. Internet Gateway (Enables public subnets to hit the web)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}

# 3. Public Subnets (For ALB / Nginx Reverse Proxy entry points)
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-sub-${count.index + 1}"
  }
}

# 4. Private Subnets (For Web/App EC2 Nodes)
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project_name}-${var.environment}-private-sub-${count.index + 1}"
  }
}

# 5. Database Subnets (Isolated for RDS Layer)
resource "aws_subnet" "database" {
  count             = length(var.database_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project_name}-${var.environment}-db-sub-${count.index + 1}"
  }
}

# 6. Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
  }
}

# 7. Public Subnet Route Table Associations
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# 8. Managed DB Subnet Group for decoupled RDS architecture
resource "aws_db_subnet_group" "rds" {
  name        = "${var.project_name}-${var.environment}-rds-subnet-group"
  description = "Database subnet group for multi-az decoupled RDS"
  subnet_ids  = aws_subnet.database[*].id

  tags = {
    Name = "${var.project_name}-${var.environment}-rds-subnet-group"
  }
}

# 9. Security Group for VPC Interface Endpoints (SSM, EC2 Messages)
resource "aws_security_group" "vpc_endpoints_sg" {
  name        = "${var.project_name}-${var.environment}-vpc-endpoints-sg"
  description = "Allow HTTPS access to AWS service VPC endpoints from the VPC"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS from VPC CIDR for SSM endpoints"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc-endpoints-sg"
  }
}

# 10. VPC Interface Endpoint for SSM
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.private[*].id
  security_group_ids = [aws_security_group.vpc_endpoints_sg.id]

  tags = {
    Name = "${var.project_name}-${var.environment}-ssm-endpoint"
  }
}

# 11. VPC Interface Endpoint for SSM Messages
resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.private[*].id
  security_group_ids = [aws_security_group.vpc_endpoints_sg.id]

  tags = {
    Name = "${var.project_name}-${var.environment}-ssmmessages-endpoint"
  }
}

# 12. VPC Interface Endpoint for EC2 Messages
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type = "Interface"
  subnet_ids        = aws_subnet.private[*].id
  security_group_ids = [aws_security_group.vpc_endpoints_sg.id]

  tags = {
    Name = "${var.project_name}-${var.environment}-ec2messages-endpoint"
  }
}