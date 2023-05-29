resource "aws_codebuild_project" "mini3_build_pro" {
  name = "mini3-build-pro"
  description = "mini3-code-build-project"
  service_role = aws_iam_role.mini3_codebuild_iam_role.arn
  
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:2.0"
    type = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true
  }
  artifacts {
    type = "S3"
    #name = data.terraform_remote_state.s3.outputs.s3_name
    location = var.s3_bucket
    path = "/"
    packaging = "ZIP"
  }

  source {
    type = "CODECOMMIT"
    location = aws_codecommit_repository.mini3_codecommit_repository.clone_url_http
  }

  logs_config {
    cloudwatch_logs {
        status = "DISABLED"
    }
    s3_logs {
        status = "DISABLED"
    }
  }
}