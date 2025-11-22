# output vpc id
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.three_tier_app_vpc.id
}
# output subnet ids
output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = { for k, subnet in aws_subnet.subnets : k => subnet.id }
}