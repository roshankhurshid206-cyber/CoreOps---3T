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
  description = "The target VPC ID where EC2 instances will reside"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for entry layer/bastion if needed"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs where application instances will be isolated"
}

variable "instance_type" {
  type        = string
  description = "EC2 compute instance sizing"
  default     = "t2.micro" # AWS Free Tier default (t3.micro can be used depending on region)
}

variable "ami_id" {
  type        = string
  description = "The AMI ID to use for the EC2 instances"
  default     = ""
}

variable "key_name" {
  type        = string
  description = "The name of the SSH key pair to associate with the instances"
  default     = ""
}