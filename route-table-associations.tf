resource "aws_route_table_association" "public_rt_assoc" {
    count = length(var.public_subnet_cidrs)
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public_rt.id

    depends_on = [ 
        aws_subnet.public_subnet,
        aws_route_table.public_rt
    ]
}

resource "aws_route_table_association" "private_rt_assoc" {
    count = length(var.private_subnet_cidrs)
    subnet_id = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.private_rt[count.index].id

    depends_on = [ 
        aws_subnet.private_subnet,
        aws_route_table.private_rt
    ]
}
