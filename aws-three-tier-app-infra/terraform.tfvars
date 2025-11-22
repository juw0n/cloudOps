# s3 and iam configurations
s3_bucket_name    = "three-tier-app-code-storage-bucket"
ec2_iam_role_name = "three-tier-app-ec2-role"

# Networking module variables
vpc_cidr_block = "10.10.0.0/16"
vpc_name       = "three-tier-app-vpc"

availability_zones = ["us-east-1a", "us-east-1b"]
subnet_config = {
  "Public-Web-Subnet-AZ-1"  = "10.10.1.0/24"
  "Private-App-Subnet-AZ-1" = "10.10.2.0/24"
  "Private-DB-Subnet-AZ-1"  = "10.10.3.0/24"
  "Public-Web-Subnet-AZ-2"  = "10.10.4.0/24"
  "Private-App-Subnet-AZ-2" = "10.10.5.0/24"
  "Private-DB-Subnet-AZ-2"  = "10.10.6.0/24"
}
project_tag = "three-tier-app"
# Internet Connectivity variables

my_ip_cidr = "41.86.149.26/32"

# Database module variables
# db_security_group_id = "sg-0abc1234def567890"
db_username = "admin"
db_password = "YourSecurePassword123!"