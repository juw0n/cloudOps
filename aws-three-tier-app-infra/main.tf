
module "networking" {
  source = "./modules/networking"

  vpc_cidr_block     = var.vpc_cidr_block
  vpc_name           = var.vpc_name
  availability_zones = var.availability_zones
  subnet_config      = var.subnet_config
  project_tag        = var.project_tag
}

module "security" {
  source = "./modules/security"

  vpc_id      = module.networking.vpc_id
  my_ip_cidr  = var.my_ip_cidr
  project_tag = var.project_tag
}

module "database" {
  source = "./modules/database"

  subnet_ids  =  module.networking.subnet_ids
  project_tag    = var.project_tag
  db_security_group_id = module.security.db_security_group_id
  db_username = var.db_username
  db_password = var.db_password
  availability_zones = var.availability_zones
}

# Create an S3 bucket for storing code
resource "aws_s3_bucket" "three_tier_app_code_storage" {
  bucket = var.s3_bucket_name

  tags = {
    Name = "three-tier-app"
  }
}

# Create an IAM role for EC2 with SSM and S3 access
resource "aws_iam_role" "three_tier_app_ec2_role" {
  name = var.ec2_iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
# Attach SSM and S3 access policies to the IAM role
resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.three_tier_app_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}
resource "aws_iam_role_policy_attachment" "s3_attach" {
  role       = aws_iam_role.three_tier_app_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}