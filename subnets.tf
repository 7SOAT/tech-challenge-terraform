resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidrs)
    vpc_id = aws_vpc.main_vpc.id  
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "main-subnet-public${count.index + 1}-${var.availability_zones[count.index]}"
    }

    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_subnet" "private_subnet" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.private_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = false

    tags = {
        Name = "main-subnet-private${count.index + 1}-${var.availability_zones[count.index]}"   
        Type = "private"
    }

    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_db_subnet_group" "main_rds_subnet_group" {
  name       = "main-rds-subnet-group"
  subnet_ids = aws_subnet.private_subnet[*].id

  tags = {
    Name = "main-rds-subnet-group"
  }

  depends_on = [ aws_subnet.private_subnet ]  
}