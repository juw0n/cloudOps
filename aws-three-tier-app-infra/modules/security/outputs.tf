# Output db_security_group_id
output "db_security_group_id" {
  description = "The ID of the database security group"
  value       = aws_security_group.private_db_sg.id
}
# Output private_app_sg_id
output "private_app_sg_id" {
  description = "The ID of the private application security group"
  value       = aws_security_group.private_app_sg.id
}