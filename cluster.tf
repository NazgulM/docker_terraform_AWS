resource "aws_ecs_cluster" "nm_cluster" {
  name = "nm-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "nm_cluster_cp" {
  cluster_name = aws_ecs_cluster.nm_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_service" "centos" {
  name            = "centos"
  cluster         = aws_ecs_cluster.nm_cluster.id
  task_definition = aws_ecs_task_definition.centos.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets = [aws_subnet.private_subnet.id]
  }
}

resource "aws_ecs_task_definition" "centos" {
  family                   = "centos"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  container_definitions = jsonencode([
    {
      name      = "centos"
      image     = "centos:8"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}