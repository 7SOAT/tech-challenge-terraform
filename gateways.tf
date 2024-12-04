resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main_vpc.id

    tags = {
        Name = "main-igw"
    }

    depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_nat_gateway" "nat_gw" {
    count = length(var.public_subnet_cidrs)
    allocation_id = aws_eip.nat_eip[count.index].id
    subnet_id = aws_subnet.public_subnet[count.index].id

    tags = {
        Name = "main-nat-gateway-${count.index + 1}"
    }

    depends_on = [ 
        aws_eip.nat_eip, 
        aws_subnet.public_subnet
    ]
}