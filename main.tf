# Overall VPC

resource "aws_vpc" "three-tier-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = true

    tags = {
      Name = "3-Tier-Architecture-VPC"
    }
  
}