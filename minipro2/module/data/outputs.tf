output "aurora_replica_endpoint" {
  value = aws_rds_cluster.mini-rds.reader_endpoint
}

output "cluster_endpoint" {
  value = aws_rds_cluster.mini-rds.endpoint
}