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

# Create public subnet 3
module "public_subnet_3" {
  source = "./modules/subnet"
  vpc_id = aws_vpc.three-tier-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1c"
  Name = "3-Tier-Public-AZ-3"
  map_public_ip_on_launch = true
  
}