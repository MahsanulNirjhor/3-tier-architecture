# Create AWS EC2 launch Template
resource "aws_launch_template" "launch_template" {
  name          = "Three-Tier-Launch-Template"
  image_id      = "ami-09988af04120b3591"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.three_tier_key_pair.key_name
  user_data     = filebase64("${path.module}/launch_data.sh")
  vpc_security_group_ids = [aws_security_group.three_tier_app_sg.id]
}

#Create an AWS Auto Scaling Group
resource "aws_autoscaling_group" "three_tier_asg" {
  desired_capacity   = 3
  max_size           = 5
  min_size           = 3
  force_delete       = true
  health_check_type = "EC2"
  target_group_arns = [aws_lb_target_group.three-tier-lb-tg.arn]
  vpc_zone_identifier = [module.private_subnet_1.id,module.private_subnet_2.id,module.private_subnet_3.id]

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
}
# Create a Bastion Host
resource "aws_instance" "bastion_host" {
  ami           = "ami-09988af04120b3591"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.three_tier_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.three_tier_bastion_sg.id]
  subnet_id = module.public_subnet_1.id
  associate_public_ip_address = true
  tags = {
    Name = "Bastion Host"
  }
}