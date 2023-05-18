resource "aws_db_subnet_group" "mini-db-subnet-group" {
  name       = "mini-db-subnet-group"
  subnet_ids = var.subnet-group-ids

  tags = merge(
    var.tags,
    {
      "name" = "${var.environment}-db-subnet-group"
    }
  )

}