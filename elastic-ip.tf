resource "aws_eip" "nat_eip" {
    count = length(var.public_subnet_cidrs)

    tags = {
        Name = "main-nat-eip-${count.index + 1}"
    }
}