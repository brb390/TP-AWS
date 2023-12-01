resource "aws_ecs_service" "bilal_ecs_service" {
  name            = "bilal-ecs-service"
  cluster         = aws_ecs_cluster.bilal_cluster.id
  task_definition = aws_ecs_task_definition.ma_task_definition.arn
  launch_type     = "FARGATE"
  desired_count   = 3

  network_configuration {
    subnets = [aws_subnet.subnetbilal1.id, aws_subnet.subnetbilal2.id, aws_subnet.subnetbilal3.id]

    security_groups  = [aws_security_group.bilal_security_group.id]
    assign_public_ip = "true"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.mon_group.arn
    container_name   = "web"
    container_port   = 80
  }
}
