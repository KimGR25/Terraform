resource "aws_ecs_cluster" "mini3_ecs_cluster" {
name = "mini3_ecs_cluster"
}

resource "aws_ecs_task_definition" "mini3_ecs_task" {
    family = "mini3-ecs-task" 
    requires_compatibilities = ["FARGATE"] 
    network_mode = "awsvpc" 
    memory = 512 
    cpu = 256 
    execution_role_arn = aws_iam_role.mini3_ecs_iam_role.arn
    task_role_arn = aws_iam_role.mini3_ecs_iam_role.arn
    container_definitions = jsonencode([
        {
            name = var.container_name
            image = "${aws_ecr_repository.mini3_ecr.repository_url}:latest"
            cpu = 256
            memory = 512
            essential = true
            portMappings = [
            {
                name = "mini3-80-tcp"
                containerPort = 80
                hostPort = 80
                appProtocol = "http"
            }
            ]
        }
    ])
    runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture = "X86_64"
    }
}

resource "aws_ecs_service" "mini3_ecs_service" {
    name = "mini3-ecs-service" 
    cluster = aws_ecs_cluster.mini3_ecs_cluster.id
    task_definition = aws_ecs_task_definition.mini3_ecs_task.arn
    launch_type = "FARGATE"
    platform_version = "LATEST"
    scheduling_strategy = "REPLICA"
    desired_count = 2

    load_balancer {
        target_group_arn = aws_lb_target_group.mini3_alb_tg.arn
        container_name = var.container_name
        container_port = 80
    }

    network_configuration {
        subnets = var.private_subnets_ids
        security_groups = var.alb_security_group_ids
        assign_public_ip = true
    }
}