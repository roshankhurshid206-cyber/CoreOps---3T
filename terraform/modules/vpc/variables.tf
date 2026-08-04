variable "project_name" {
  type        = string
  description = "Project name for tracking tags"
}

variable "environment" {
  type        = string
  description = "Deployment stage name"
}

variable "vpc_cidr" {
  type        = string
  description = "The core CIDR block for the custom VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the frontend/web subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the internal backend subnets"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the isolated storage subnets"
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}