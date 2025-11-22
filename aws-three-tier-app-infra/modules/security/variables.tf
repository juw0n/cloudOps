# 
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
# my IP CIDR for access
variable "my_ip_cidr" {
  description = "Your IP address in CIDR notation (e.g., 203.0.113.5/32)"
  type        = string
}
# 
variable "project_tag" {  
  description = "Project tag for resources"
  type        = string
}