# # Security Groups helps to tighten the rules around which traffic will be allowed to our Elastic Load Balancers and EC2 instances.

# Public LoadBalancer Security Group
resource "aws_security_group" "public_lb_sg" {
  name        = "Public-LoadBalancer-SG"
  description = "Security group for public-facing load balancer"
  vpc_id      = var.vpc_id

    ingress {
    description = "Allow HTTP from my IP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
    }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name ="${var.project_tag}-Public-LB-SG"
  }
}

# public web instances security group
resource "aws_security_group" "public_web_sg" {
  name        = "Public-Web-SG"
  description = "Security group for public web tier EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow HTTP from Load Balancer SG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_lb_sg.id]
  }

  ingress {
    description = "Allow HTTP from my IP for testing"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_tag}-Public-Web-SG"
  }
}

# Internal load balancer security group
resource "aws_security_group" "internal_lb_sg" {
  name        = "Internal-LoadBalancer-SG"
  description = "Security group for internal load balancer"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow HTTP from Public Web SG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_web_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project_tag}-Internal-LB-SG"
  }
}

# Private instances security group
resource "aws_security_group" "private_app_sg" {
  name        = "Private-App-SG"
  description = "Security group for private application tier EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow TCP 4000 from Internal Load Balancer SG"
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    security_groups = [aws_security_group.internal_lb_sg.id]
  }

  ingress {
    description     = "Allow TCP 4000 from my IP for testing"
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    cidr_blocks = [var.my_ip_cidr]
  }


  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_tag}-Private-App-SG"
  }
}

# Private database instances security group
resource "aws_security_group" "private_db_sg" {
  name        = "Private-DB-SG"
  description = "Security group for private database tier EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow TCP 5432 from Private App SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_app_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_tag}-Private-DB-SG"
  }
}