resource "aws_codepipeline" "mini3_codepipeline" {
    name = "mini3-codepipeline"
    role_arn = aws_iam_role.mini3_codepipeline_iam_role.arn
    artifact_store {
        location = var.s3_bucket
        type = "S3"
    }
    # sorcecommit 부분
    stage {
        name = "Source"
        action {
            name = "Source"
            category = "Source"
            owner = "AWS" 
            provider = "CodeCommit"
            version = "1"
            output_artifacts = ["source_output"]
            configuration = {
                RepositoryName = "mini3-Codecommit-Repository"
                BranchName = "master"
            }
        }
    }
    # codebuild
    stage {
        name = "Build"
        action {
            name = "Build"
            category = "Build"
            owner = "AWS"
            provider = "CodeBuild"
            input_artifacts = ["source_output"]
            output_artifacts = ["build_output"]
            version = "1"
            configuration = {
                ProjectName = "mini3-build-pro"
            }
        }
    }
    stage {
        name = "Deploy"
        action {
            name = "Deploy"
            category = "Deploy"
            owner = "AWS"
            provider = "ECS"
            input_artifacts = ["build_output"]
            version = "1"
            configuration = {
                ClusterName = "mini3_ecs_cluster"
                ServiceName = "mini3-ecs-service"
                FileName = "imagedefinitions.json"
            }
        }
    }
}