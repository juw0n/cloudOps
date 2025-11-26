# Project tag
variable "project_tag" {
  description = "Tag to identify resources belonging to the project"
  type        = string
}
# subnet ID
variable "subnet_ids" {
  description = "The ID of the subnet where the compute instance will be launched"
  type        = map(string)
}
# Private insance sg
variable "private_instance_sg_id" {
  description = "The security group ID for the private compute instance"
  type        = string
}
# Instance type
variable "app_instance_type" {
  description = "The instance type for the application tier instances"
  type        = string
}
# EC2 IAM Instance Profile Name
variable "ec2_iam_instance_profile_name" {
  description = "The name of the IAM instance profile to attach to EC2 instances"
  type        = string
}