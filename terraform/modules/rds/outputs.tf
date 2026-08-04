output "endpoint" {
  value       = aws_db_instance.mysql.endpoint
  description = "The RDS MySQL endpoint (host:port), used by application connection strings"
}

output "address" {
  value       = aws_db_instance.mysql.address
  description = "The RDS MySQL host address"
}

output "port" {
  value       = aws_db_instance.mysql.port
  description = "The RDS MySQL listener port"
}

output "db_name" {
  value       = aws_db_instance.mysql.db_name
  description = "The default database name provisioned on the instance"
}

output "db_security_group_id" {
  value       = aws_security_group.db_sg.id
  description = "Security group ID isolating the database tier"
}
