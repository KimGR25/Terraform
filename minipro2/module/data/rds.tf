# Aurora Mysql 
resource "aws_rds_cluster" "mini-rds" {
  cluster_identifier      = "mini-rds"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.2"
  database_name           = "minirds"
  master_username         = "admin"
  master_password         = "soldesk1."
  backup_retention_period = 7 
  db_subnet_group_name   = aws_db_subnet_group.mini-db-subnet-group.name
  skip_final_snapshot    = true
  vpc_security_group_ids = var.rds-security-group-ids
}

# Aurora Mysql 리플리카 
resource "aws_rds_cluster_instance" "mini-rds-replica" {
  count               = 2  
  engine              = "aurora-mysql"
  identifier          = "mini-rds-replica-${count.index}"
  cluster_identifier  = aws_rds_cluster.mini-rds.id
  instance_class      = "db.t3.small"  
}


