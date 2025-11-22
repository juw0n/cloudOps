# VPC cidr block, name and id
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "vpc_name" {
  description = "The name tag for the VPC"
  type        = string
}

# availability zones
variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}
# subnet configurations
variable "subnet_config" {
  description = "List of subnet configurations"
  type = map(string)
}

variable "project_tag" {  
  description = "Project tag for resources"
  type        = string
}