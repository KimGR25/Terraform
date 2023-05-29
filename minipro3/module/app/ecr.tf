resource "aws_ecr_repository" "mini3_ecr" {
  name                  = "mini3_ecr"
  image_tag_mutability  = "MUTABLE"

  force_delete = true

  image_scanning_configuration {
    scan_on_push = false
  }
  
}
