# 1. Isolated Security Group for RDS Engine
resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-${var.environment}-db-sg"
  description = "Restrict database traffic strictly to compute application nodes"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow MySQL traffic from web application tier only"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.web_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-db-sg"
  }
}

# 2. Relational Database Service (RDS) MySQL Instance
resource "aws_db_instance" "mysql" {
  identifier             = "${var.project_name}-${var.environment}-db"
  allocated_storage      = var.allocated_storage
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = var.db_instance_class
  db_name                = "appdb"
  username               = var.db_username
  password               = var.db_password # Standard production layouts shift this to Secrets Manager
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true

  tags = {
    Name = "${var.project_name}-${var.environment}-rds"
  }
}