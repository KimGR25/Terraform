# Aurora Mysql 
resource "aws_rds_cluster" "mini3_rds" {
  cluster_identifier      = "mini3-rds"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.2"
  database_name           = "mini3"
  master_username         = "admin"
  master_password         = "soldesk1."
  backup_retention_period = 7 
  db_subnet_group_name   = aws_db_subnet_group.mini3_db_subnet_group.name
  skip_final_snapshot    = true
  vpc_security_group_ids = var.data_security_group_ids
}

# Aurora Mysql 리플리카 
resource "aws_rds_cluster_instance" "mini-rds-replica" {
  count               = 2  
  engine              = "aurora-mysql"
  identifier          = "mini3-rds-replica-${count.index}"
  cluster_identifier  = aws_rds_cluster.mini3_rds.id
  instance_class      = "db.t3.small"  
}
