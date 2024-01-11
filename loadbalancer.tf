# Create a Load Balancer
resource "aws_lb" "Three_tier_lb" {
  name = "Three_tier_lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.three_tier_elb_sg.id]

  subnet_mapping {
    subnet_id = module.public_subnet_1.id
  }
  subnet_mapping {
    subnet_id = module.public_subnet_2.id
  }
  subnet_mapping {
    subnet_id = module.public_subnet_3.id
  }
}

# Create a Target Group
resource "aws_lb_target_group" "three_tier_lb_tg" {
  name = "three_tier_lb_tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.three-tier-vpc.id
  target_type = "instance"

  stickiness {
    enabled = true
    type = "app_cookie"
  }
}

# Load Balancer listener to Target group
resource "aws_lb_listener" "lb_listener" {
    load_balancer_arn = aws_lb.Three_tier_lb
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.three_tier_lb_tg.arn
    }  
}