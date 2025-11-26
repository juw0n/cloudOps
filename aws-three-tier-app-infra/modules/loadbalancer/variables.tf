# Project tag variable
variable "project_tag" {
  description = "Tag to identify resources for the project"
  type        = string
}
# App instance IDs variable
variable "app_instance_ids" {
  description = "IDs of the application server instances"
  type        = list(string)
}
