# Create 3 Public Subnets
module "public_subnet_1" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  Name = "3-Tier-Public-AZ-1"
  map_public_ip_on_launch = true
  
}

module "public_subnet_2" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1b"
  Name = "3-Tier-Public-AZ-2"
  map_public_ip_on_launch = true
  
}

module "public_subnet_3" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1c"
  Name = "3-Tier-Public-AZ-3"
  map_public_ip_on_launch = true
  
}

# Create 3 Private subnets
module "private_subnet_1" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  Name = "3-Tier-Private-AZ-1"
}

module "private_subnet_2" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  Name = "3-Tier-Private-AZ-2"
}

module "private_subnet_3" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1c"
  Name = "3-Tier-Private-AZ-3"
}

# Create 3 Subnets for DB
module "db_subnet_1" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.6.0/24"
  availability_zone = "us-east-1a"
  Name = "3-Tier-DB-AZ-1"
}
module "db_subnet_2" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.7.0/24"
  availability_zone = "us-east-1b"
  Name = "3-Tier-DB-AZ-2"
}
module "db_subnet_3" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.8.0/24"
  availability_zone = "us-east-1c"
  Name = "3-Tier-DB-AZ-3"
}