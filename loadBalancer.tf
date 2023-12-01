resource "aws_lb_target_group" "mon_group" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.bilalvpc.id
    target_type = "ip"
}



resource "aws_lb" "bilal_load_balancer" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.bilal_security_group.id]
  subnets            = [aws_subnet.subnetbilal1.id, aws_subnet.subnetbilal2.id, aws_subnet.subnetbilal3.id]

  enable_deletion_protection = false
}
