# Create a VPC
resource "aws_vpc" "three_tier_app_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

# Create Subnets
resource "aws_subnet" "subnets" {
  for_each = var.subnet_config
  vpc_id            = aws_vpc.three_tier_app_vpc.id
  cidr_block       = each.value
  availability_zone = strcontains(each.key, "AZ-1") ? var.availability_zones[0] : var.availability_zones[1]
  tags = {
    Name = each.key
  }
}

# Internet Connectivity
# Create an Internet Gateway
resource "aws_internet_gateway" "three_tier_app_igw" {
  vpc_id = aws_vpc.three_tier_app_vpc.id #Attach to the VPC
  tags = {
    Name = "${var.project_tag}-igw"
  }
}
# Create NAT Gateway for app-layer private subnets in each AZ
# Allocate Elastic IPs for NAT Gateways
resource "aws_eip" "nat_eip_az1" {
  domain = "vpc"
  tags = {
    Name = "${var.project_tag}-nat-eip-az1"
  }
}
resource "aws_eip" "nat_eip_az2" {
  domain = "vpc"
  tags = {
    Name = "${var.project_tag}-nat-eip-az2"
  }
}
# Create NAT Gateways
resource "aws_nat_gateway" "nat_gw_az1" {
  allocation_id = aws_eip.nat_eip_az1.id
  subnet_id     = aws_subnet.subnets["Public-Web-Subnet-AZ-1"].id
  tags = {
    Name = "${var.project_tag}-nat-gw-az1"
  }
}
resource "aws_nat_gateway" "nat_gw_az2" {
  allocation_id = aws_eip.nat_eip_az2.id
  subnet_id     = aws_subnet.subnets["Public-Web-Subnet-AZ-2"].id
  tags = {
    Name = "${var.project_tag}-nat-gw-az2"
  }
}
# Create Route Tables
# Create route table for the public web layer subnets
resource "aws_route_table" "public_web_rt" {
  vpc_id = aws_vpc.three_tier_app_vpc.id
  tags = {
    Name = "${var.project_tag}-public-web-rt"
  }
}
# Create route to internet gateway in the public web layer subnets
resource "aws_route" "public_web_route" {
  route_table_id         = aws_route_table.public_web_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.three_tier_app_igw.id
}
# # route association with public subnets
# resource "aws_route_table_association" "public_subnet_az1" {
#   subnet_id      = aws_subnet.subnets["Public-Web-Subnet-AZ-1"].id
#   route_table_id = aws_route_table.public_web_rt.id
# }
# resource "aws_route_table_association" "public_subnet_az2" {
#   subnet_id      = aws_subnet.subnets["Public-Web-Subnet-AZ-2"].id
#   route_table_id = aws_route_table.public_web_rt.id
# }
# Associate public subnets with the public route table
resource "aws_route_table_association" "public_web_rt_association" {
  for_each = { for k, s in aws_subnet.subnets : k => s if strcontains(k, "Public-Web-Subnet") }

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_web_rt.id
}
# Create route table for private app layer subnet in the two availability zones
resource "aws_route_table" "private_app_rt_az1" {
  vpc_id = aws_vpc.three_tier_app_vpc.id
  tags = {
    Name = "${var.project_tag}-private-app-rt-az1"
  }
}
resource "aws_route_table" "private_app_rt_az2" {
  vpc_id = aws_vpc.three_tier_app_vpc.id
  tags = {
    Name = "${var.project_tag}-private-app-rt-az2"
  }
}
# Create route for private app layer subnet to NAT gateway in private route tables
resource "aws_route" "private_app_az1_route" {
  route_table_id         = aws_route_table.private_app_rt_az1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw_az1.id
}
resource "aws_route" "private_app_az2_route" {
  route_table_id         = aws_route_table.private_app_rt_az2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw_az2.id
}

# Associate private subnets with the private route tables
resource "aws_route_table_association" "private_app_az1_rt_association" {
  subnet_id      = aws_subnet.subnets["Private-App-Subnet-AZ-1"].id
  route_table_id = aws_route_table.private_app_rt_az1.id
}
resource "aws_route_table_association" "private_app_az2_rt_association" {
  subnet_id      = aws_subnet.subnets["Private-App-Subnet-AZ-2"].id
  route_table_id = aws_route_table.private_app_rt_az2.id
}
