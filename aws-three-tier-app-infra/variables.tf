# s3 buket name for code storage
variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store application code."
  type        = string
}

# IAM role name for EC2 instances
variable "ec2_iam_role_name" {
  description = "The name of the IAM role to be assigned to EC2 instances."
  type        = string
}

# Networking module variables
# availability zones
variable "availability_zones" {
  description = "A list of availability zones to deploy resources in."
  type        = list(string)
}

# VPC cidr block, name and id
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "vpc_name" {
  description = "The name tag for the VPC"
  type        = string
}

variable "subnet_config" {
  description = "A map of subnet names to their CIDR blocks."
  type        = map(string)
}

variable "project_tag" {
  description = "Project tag for resources"
  type        = string
}

# Seciurity module variables
# my IP CIDR for access
variable "my_ip_cidr" {
  description = "Your IP address in CIDR notation (e.g., 203.0.113.5/32)"
  type        = string
}

# Database module variables
# DB subnet ids and security group id
# variable "db_subnet_ids" {
#   description = "List of subnet IDs for the database"
#   type        = list(string)
# }

# variable "db_security_group_id" {
#   description = "The security group ID for the database"
#   type        = string
# }

# Database username
variable "db_username" {
  description = "Master username for the database"
  type        = string
}
variable "db_password" {
  description = "Master user password"
  type = string
}