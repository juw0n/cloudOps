# Project tag variable
variable "project_tag" {
  description = "Tag to identify resources for the project"
  type        = string
}
# db dubnet ids variable
variable "subnet_ids" {
  description = "Map of subnet IDs for the database"
  type        = map(string)
}

# Database username
variable "db_username" {
  description = "Master username for the database"
  type        = string
}
variable "db_password" {
  description = "Master user password"
  type = string
}
# Database security group ID
variable "db_security_group_id" {
  description = "Security group ID for the database"
  type        = string
}
# availability zones
variable "availability_zones" {
  description = "List of availability zones for the subnets"
  type        = list(string)
}