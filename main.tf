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