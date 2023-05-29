# Cloud Build 역활 생성
resource "aws_iam_role" "mini3_codebuild_iam_role" {
  name = "mini3-codebuild-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# AWSCodeBuildAdminAccess 정책연결
resource "aws_iam_role_policy_attachment" "mini3_codebuild_iam_role_attachment" {
role = aws_iam_role.mini3_codebuild_iam_role.name
policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}
# AmazonEC2ContainerRegistryFullAccess 정책연결
resource "aws_iam_role_policy_attachment" "mini3_codebuild_iam_role_attachment2" {
role = aws_iam_role.mini3_codebuild_iam_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
# AmazonS3FullAccess 정책연결
resource "aws_iam_role_policy_attachment" "mini3_codebuild_iam_role_attachment3" {
role = aws_iam_role.mini3_codebuild_iam_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "mini3_codebuild_profile" {
  name = "mini3-codebuild-profile"
  role = aws_iam_role.mini3_codebuild_iam_role.name
}

# Cloud Build 역활 생성
resource "aws_iam_role" "mini3_codepipeline_iam_role" {
  name = "mini3-codepipeline-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# AWSCodePipeline_FullAccess 정책 연결
resource "aws_iam_role_policy_attachment" "mini3_codepipeline_iam_role_attach" {
role = aws_iam_role.mini3_codepipeline_iam_role.name
policy_arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}
# AmazonS3FullAccess 정책 연결
resource "aws_iam_role_policy_attachment" "mini3_codepipeline_iam_role_attach2" {
role = aws_iam_role.mini3_codepipeline_iam_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
# AWSCodeCommitFullAccess 정책 연결
resource "aws_iam_role_policy_attachment" "mini3_codepipeline_iam_role_attach3" {
role = aws_iam_role.mini3_codepipeline_iam_role.name
policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}
# AWSCodeBuildAdminAccess 정책 연결
resource "aws_iam_role_policy_attachment" "mini3_codepipeline_iam_role_attach4" {
role = aws_iam_role.mini3_codepipeline_iam_role.name
policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildAdminAccess"
}
# AmazonECSTaskExecutionRolePolicy 정책 연결
resource "aws_iam_role_policy_attachment" "mini3_codepipeline_iam_role_attach5" {
role = aws_iam_role.mini3_codepipeline_iam_role.name
policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
# AmazonECS_FullAccess 정책 연결
resource "aws_iam_role_policy_attachment" "mini3_codepipeline_iam_role_attach6" {
role = aws_iam_role.mini3_codepipeline_iam_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}
# AWSCodeDeployRoleForECS 정책 연결
resource "aws_iam_role_policy_attachment" "mini3_codepipeline_iam_role_attach7" {
role = aws_iam_role.mini3_codepipeline_iam_role.name
policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployRoleForECS"
}

resource "aws_iam_instance_profile" "mini3_codepipeline_profile" {
  name = "mini3-codepipeline-profile"
  role = aws_iam_role.mini3_codepipeline_iam_role.name
}