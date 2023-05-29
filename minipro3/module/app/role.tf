# Bastion 역활 생성
resource "aws_iam_role" "mini3_bastion_iam_role" {
  name = "mini3-bastion-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# AdministratorAccess 정책 연결 
resource "aws_iam_role_policy_attachment" "mini3_bastion_iam_role_attachment" {
  role       = aws_iam_role.mini3_bastion_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "mini3_bastion_instance_profile" {
  name = "mini3-was-instance-profile"
  role = aws_iam_role.mini3_bastion_iam_role.name
}

# ECS 역활 생성
resource "aws_iam_role" "mini3_ecs_iam_role" {
  name = "mini3-ecs-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# AmazonECSTaskExecutionRolePolicy 정책 연결 
resource "aws_iam_role_policy_attachment" "mini3_ecs_iam_role_attachment" {
  role       = aws_iam_role.mini3_ecs_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
# AmazonS3FullAccess 정책 연결 
resource "aws_iam_role_policy_attachment" "mini3_ecs_iam_role_attachment2" {
  role       = aws_iam_role.mini3_ecs_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
# AmazonECS_FullAccess 정책 연결 
resource "aws_iam_role_policy_attachment" "mini3_ecs_iam_role_attachment3" {
  role       = aws_iam_role.mini3_ecs_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

resource "aws_iam_instance_profile" "mini3_ecs_profile" {
  name = "mini3_ecs_profile"
  role = aws_iam_role.mini3_ecs_iam_role.name
}