variable "project_name" {
  type        = string
  description = "Project name for tracking tags"
}

variable "environment" {
  type        = string
  description = "Deployment stage name"
}

variable "vpc_id" {
  type        = string
  description = "The target VPC ID where database groups reside"
}

variable "db_subnet_group_name" {
  type        = string
  description = "Subnet group identifier passed down from the network module"
}

variable "web_security_group_id" {
  type        = string
  description = "The compute firewall security group ID allowed to communicate with our DB"
}

variable "db_instance_class" {
  type        = string
  description = "The compute sizing for our database node"
  default     = "db.t3.micro" # Standard AWS Free Tier sizing tier
}

variable "allocated_storage" {
  type        = number
  description = "The storage space allocated in GB"
  default     = 20 # 20GB of gp2/gp3 is within the standard free limits
}

variable "db_username" {
  type        = string
  description = "Master username for the MySQL instance"
  default     = "admin"
}

variable "db_password" {
  type        = string
  description = "Master password for the MySQL instance"
  sensitive   = true
  default     = "SecurePasswordChangeMe2026!"
}