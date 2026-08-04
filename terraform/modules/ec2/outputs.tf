output "instance_ids" {
  value       = aws_instance.web[*].id
  description = "List of IDs assigned to the provisioning compute instances"
}

output "private_ips" {
  value       = aws_instance.web[*].private_ip
  description = "List of internal private IP addresses for configuration management"
}

output "public_ips" {
  value       = aws_instance.web[*].public_ip
  description = "List of public IP addresses assigned to instances (if routed publicly)"
}

output "security_group_id" {
  value       = aws_security_group.web_sg.id
  description = "The application firewall profile ID"
}

output "instance_profile_arn" {
  value       = aws_iam_instance_profile.ec2_profile.arn
  description = "The IAM instance profile ARN attached to EC2 instances for SSM access"
}