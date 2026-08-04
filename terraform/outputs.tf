# ---------------------------------------------------------------------------
# Root-level aggregations surfaced for operators, Ansible, and CI/CD.
# ---------------------------------------------------------------------------

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC identifier hosting the three-tier architecture"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "Public subnet IDs (entry layer)"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "Private subnet IDs hosting the compute tier"
}

output "database_subnet_ids" {
  value       = module.vpc.database_subnet_ids
  description = "Isolated database subnet IDs"
}

output "db_endpoint" {
  value       = module.rds.endpoint
  description = "RDS MySQL endpoint consumed by the application tier"
}

output "db_address" {
  value       = module.rds.address
  description = "RDS MySQL host address"
}

output "db_port" {
  value       = module.rds.port
  description = "RDS MySQL listener port"
}

output "web_instance_ids" {
  value       = module.ec2.instance_ids
  description = "Compute tier EC2 instance IDs (Ansible inventory targets)"
}

output "web_private_ips" {
  value       = module.ec2.private_ips
  description = "Private IPs of the compute tier (Ansible inventory hosts)"
}
