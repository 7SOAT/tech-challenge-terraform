resource "aws_lb_target_group" "main_tg" {
    name = "main-target-group"
    port = 80
    protocol = "TCP"
    vpc_id = aws_vpc.main_vpc.id
    target_type = "ip"

    health_check {
      enabled = true
      path = "/health"
      interval = 30
      timeout = 10
      healthy_threshold = 2
      unhealthy_threshold = 2
      protocol = "HTTP"
    }

    tags = {
        Name = "main-target-group"
    }

    depends_on = [ aws_vpc.main_vpc ]
}

# resource "aws_lb_target_group_attachment" "main_eks_targets" {
#   count = length(data.aws_instances.main_eks_nodes.private_ips)
#   target_group_arn = aws_lb_target_group.main_tg.arn
#   target_id = data.aws_instances.main_eks_nodes.private_ips[count.index]
#   port = 80

#   depends_on = [ aws_lb_target_group.main_tg ]
# }