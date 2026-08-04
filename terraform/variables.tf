variable "aws_region" {
  type        = string
  description = "The target AWS region for deployment"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment name"
  default     = "dev"
}

variable "project_name" {
  type        = string
  description = "Name of the project used for resource naming"
  default     = "coreops-3t"
}

variable "key_name" {
  type        = string
  description = "SSH key pair name attached to EC2 instances"
  default     = ""
}

variable "ami_id" {
  type        = string
  description = "Override AMI ID for EC2 instances (empty = latest Ubuntu 22.04 LTS)"
  default     = "ami-0d001f8052688dc45"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the compute tier"
  default     = "t2.micro"
}

variable "db_instance_class" {
  type        = string
  description = "RDS instance class for the storage tier"
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  description = "Allocated GP storage in GB for the RDS instance"
  default     = 20
}

variable "db_username" {
  type        = string
  description = "Master username for the RDS MySQL instance"
  default     = "admin"
}

variable "db_password" {
  type        = string
  description = "Master password for the RDS MySQL instance"
  sensitive   = true
  default     = "SecurePasswordChangeMe2026!"
}
