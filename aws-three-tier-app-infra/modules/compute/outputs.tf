# app instance ids
output "app_instance_ids" {
  description = "IDs of the application server instances"
  value       = aws_instance.app_instances[0].id
}
