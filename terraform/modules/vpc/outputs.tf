output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the custom VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "List of IDs of public subnets"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "List of IDs of private subnets"
}

output "db_subnet_group_name" {
  value       = aws_db_subnet_group.rds.name
  description = "The name of the database subnet group for RDS"
}

output "vpc_cidr_block" {
  value       = aws_vpc.main.cidr_block
  description = "The core internal CIDR range block of our network"
}

output "database_subnet_ids" {
  value       = aws_subnet.database[*].id
  description = "List of IDs of database subnets"
}