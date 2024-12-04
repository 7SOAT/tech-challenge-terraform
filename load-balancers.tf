resource "aws_lb" "nlb" {
    name = "tech-challenge-nlb"
    internal = true
    load_balancer_type = "network"
    subnets = aws_subnet.private_subnet[*].id
    security_groups = [aws_security_group.nlb_sg.id]

    enable_deletion_protection = false

    tags = {
        Name = "Network Load Balancer"
    }

    depends_on = [ 
        aws_subnet.private_subnet, 
        aws_lb_target_group.main_tg 
    ]
}