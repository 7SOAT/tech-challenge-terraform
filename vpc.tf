resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "main-vpc"
  }
  
  enable_dns_support = true
  enable_dns_hostnames = true
}