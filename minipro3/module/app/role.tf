# WAS 서버에서 s3에 .zip 파일을 가져올 수 있도록 Role 생성
resource "aws_iam_role" "mini3_was_iam_role" {
  name = "mini3-was-role"

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

resource "aws_iam_role_policy_attachment" "mini3_was_iam_role_attachment" {
  role       = aws_iam_role.mini3_was_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "mini3_was_instance_profile" {
  name = "mini3-was-instance-profile"
  role = aws_iam_role.mini3_was_iam_role.name
}

#Jenkins가 S3에 파일 업로드하고 CodeDeploy에게 Deployment 생성 및 배포 요청할 수 있도록 Role 생성
resource "aws_iam_role" "mini3_jenkins_iam_role" {
  name = "mini3-jenkins-role"

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

resource "aws_iam_role_policy_attachment" "mini3_jenkins_s3_policy_attachment" {
  role       = aws_iam_role.mini3_jenkins_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "mini3_jenkins_codedeploy_policy_attachment" {
  role       = aws_iam_role.mini3_jenkins_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

resource "aws_iam_role_policy_attachment" "mini3_jenkins_codecommit_policy_attachment" {
  role       = aws_iam_role.mini3_jenkins_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
}

resource "aws_iam_instance_profile" "mini3_jenkins_instance_profile" {
  name = "mini3-jenkins-instance-profile"
  role = aws_iam_role.mini3_jenkins_iam_role.name
}

