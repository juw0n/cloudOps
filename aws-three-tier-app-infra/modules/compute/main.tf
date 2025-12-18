# App-tier Instances
resource "aws_instance" "app_instances" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.app_instance_type
  subnet_id     = var.subnet_ids["Private-App-Subnet-AZ-1"]
  vpc_security_group_ids = [var.private_instance_sg_id]
  iam_instance_profile = var.ec2_iam_instance_profile_name

  tags = {
    Name = "${var.project_tag}-App-Instance-AZ1"
  }
}
# Lookup latest Amazon Linux 2 AMI (HVM, Kernel 5.10)
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}