# app instance ids
output "app_instance_id" {
  description = "IDs of the application server instances"
  value       = aws_instance.app_instances.id
}
