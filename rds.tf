# Configure 3 subnets for Data layer
resource "aws_db_subnet_group" "db-subnet-group" {
  name       = "db-subnet-group"
  subnet_ids = [module.db_subnet_1.id,module.public_subnet_2.id,module.db_subnet_3.id]

  tags = {
    Name = "Subnet group for Data Layer"
  }
}

# RDS instance for the Data Layer
resource "aws_db_instance" "db-instance" {
  allocated_storage    = 10
  db_name                 = "Data_Tier_DB"
  engine               = "mysql"
  engine_version       = "8.0.32"
  instance_class       = "db.t2.micro"
  manage_master_user_password = true
  username             = "admin"
  db_subnet_group_name = aws_db_subnet_group.db-subnet-group.name
  vpc_security_group_ids = [aws_security_group.three_tier_db_sg.id]
  skip_final_snapshot  = true
  
}