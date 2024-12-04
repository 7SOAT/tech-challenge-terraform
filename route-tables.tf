resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "main-rtb-public"
    }

    depends_on = [
        aws_vpc.main_vpc,
        aws_internet_gateway.igw
    ]
}

resource "aws_route_table" "private_rt" {
    count = length(var.private_subnet_cidrs)
    vpc_id = aws_vpc.main_vpc.id


    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw[count.index].id
    }

    tags = {
        Name = "main-rtb-private${count.index + 1}-${var.availability_zones[count.index]}"
    }

    depends_on = [ 
        aws_vpc.main_vpc,
        aws_nat_gateway.nat_gw
    ]
}