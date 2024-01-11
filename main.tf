# Overall VPC

resource "aws_vpc" "three-tier-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = true

    tags = {
      Name = "3-Tier-Architecture-VPC"
    }
  
}

# Internet Gateway for VPC to have connectivity
resource "aws_internet_gateway" "three-tier-igw" {
    vpc_id = aws_vpc.three-tier-vpc.id

    tags = {
      Name = "3-Tier-Architecture-IGW"
    }
  
} 

# Public Route Table for Web Tier
resource "aws_route_table" "three-tier-web-rt" {
    vpc_id = aws_vpc.three-tier-vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.three-tier-igw.id
    }

    tags = {
      Name = "3-Tier-Architecture-Web-RT"
    }
  
}

# Attach the 3 public subnets for web tier we created using modules
resource "aws_route_table_association" "Public_RT_1" {
  route_table_id = aws_route_table.three-tier-web-rt.id
  subnet_id = module.public_subnet_1.id
}
resource "aws_route_table_association" "Public_RT_2" {
  route_table_id = aws_route_table.three-tier-web-rt.id
  subnet_id = module.public_subnet_2.id
}
resource "aws_route_table_association" "Public_RT_3" {
  route_table_id = aws_route_table.three-tier-web-rt.id
  subnet_id = module.public_subnet_3.id
}

# Private Route Table for Application Tier
resource "aws_route_table" "three-tier-app-rt" {
    vpc_id = aws_vpc.three-tier-vpc.id

    route = {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.Three_Tier_NAT.id
    }

    tags = {
      Name = "3-Tier-Architecture-App-RT"
    }
  
}

# Private Application Route Table Subnet Assoiations
resource "aws_route_table_association" "Private_RT_1" {
  route_table_id = aws_route_table.three-tier-app-rt.id
  subnet_id = module.private_subnet_1.id
}
resource "aws_route_table_association" "Private_RT_2" {
  route_table_id = aws_route_table.three-tier-app-rt.id
  subnet_id = module.private_subnet_2.id
}
resource "aws_route_table_association" "Private_RT_3" {
  route_table_id = aws_route_table.three-tier-app-rt.id
  subnet_id = module.private_subnet_3.id
}

# Private Route Table for Data Tier
resource "aws_route_table" "three-tier-data-rt" {
  vpc_id = aws_vpc.three-tier-vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.Three_Tier_NAT.id
  }

  tags = {
    Name = "3-Tier-Architecture-Data-RT"
  }
  
}

# Data Route Table Subnet Assoiations
resource "aws_route_table_association" "Data_RT_1" {
  route_table_id = aws_route_table.three-tier-data-rt.id
  subnet_id = module.db_subnet_1.id
}
resource "aws_route_table_association" "Data_RT_2" {
  route_table_id = aws_route_table.three-tier-data-rt.id
  subnet_id = module.db_subnet_2.id
}
resource "aws_route_table_association" "Data_RT_3" {
  route_table_id = aws_route_table.three-tier-data-rt.id
  subnet_id = module.db_subnet_3.id
}
