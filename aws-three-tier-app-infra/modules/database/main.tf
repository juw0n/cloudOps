# Create RDS DB subnet group resource
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_tag}-db-subnet-group"
  description = "Subnet group for Aurora MySQL cluster"
  subnet_ids = [
    var.subnet_ids["Private-DB-Subnet-AZ-1"],
    var.subnet_ids["Private-DB-Subnet-AZ-2"]
  ]

  tags = {
    Name = "${var.project_tag}-db-subnet-group"
  }
}

# Create RDS Aurora database cluster
resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier      = "${var.project_tag}-aurora-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.04.0"
  database_name           = "three_tier_app_db"
  master_username         = var.db_username
  master_password         = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids  = [var.db_security_group_id]
  skip_final_snapshot     = true
  tags = {
    Name = "${var.project_tag}-aurora-cluster"
  }
}
# Aurora Cluster Instances
resource "aws_rds_cluster_instance" "aurora_instances" {
  for_each          = {
    az1 = var.availability_zones[0]
    az2 = var.availability_zones[1]
  }
  identifier          = "${var.project_tag}-aurora-instance-${each.key}"
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = "db.t3.medium"
  engine              = aws_rds_cluster.aurora_cluster.engine
  engine_version      = aws_rds_cluster.aurora_cluster.engine_version
  publicly_accessible = false
  availability_zone = each.value
  tags = {
    Name = "${var.project_tag}-aurora-instance-${each.key}"
  }
}
