# Create an AMI from the EC2 instance
resource "aws_ami_from_instance" "app_server_ami" {
  name               = "${var.project_tag}-app-server-ami"
  source_instance_id = var.app_instance_id
  depends_on         = [aws_instance.app_server]
}