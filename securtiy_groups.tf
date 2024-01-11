# Security groups for app/web layer
resource "aws_security_group" "three_tier_app_sg" {
  name        = "Three_Tier_app_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.three-tier-vpc.id

  ingress {
    description     = "SSH into the instance from bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_host_sg.id]
  }
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.three_tier_elb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "three_tier_app_sg"
  }
}

# Security groups for database layer
resource "aws_security_group" "three_tier_db_sg" {
  name        = "Three_Tier_db_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.three-tier-vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.three_tier_app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "three_tier_db_sg"
  }
}

# Security groups for load balancer
resource "aws_security_group" "three_tier_elb_sg" {
  name        = "Three_Tier_elb_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.three-tier-vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "three_tier_elb_sg"
  }
}

# Security groups for bastion host
resource "aws_security_group" "bastion_host_sg" {
  name        = "Bastion_host_sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.three-tier-vpc.id

  ingress {
    description = "SSH from VPC into instances"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion_host_sg"
  }
}