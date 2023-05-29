resource "aws_instance" "mini3_bastion_intence" {
  ami           = "ami-073858dcf4e30e586"
  instance_type = "t2.micro"
  key_name      = "mykeypair"
  subnet_id     = var.public_subnets_ids
  vpc_security_group_ids = var.bastion_security_group_ids

  user_data = base64encode(templatefile("./script/bastion.sh", {
  ecr_url = aws_ecr_repository.mini3_ecr.repository_url
  ecr_url2 = replace(aws_ecr_repository.mini3_ecr.repository_url, "/mini3_ecr", "")
  commit_url = var.code_commit_url
}))

  iam_instance_profile = aws_iam_instance_profile.mini3_bastion_instance_profile.name

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment} Bastion Instence"
    }
  )

}