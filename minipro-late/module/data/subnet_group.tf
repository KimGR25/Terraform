resource "aws_db_subnet_group" "mini3_db_subnet_group" {
  name       = "mini3-db-subnet-group"
  subnet_ids = var.data_subnet_ids
  
  tags = merge(
    var.tags,
    {
      "name" = "${var.environment} DB Subnet Group"
    }
  )

}