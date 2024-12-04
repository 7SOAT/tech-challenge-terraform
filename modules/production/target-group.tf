resource "aws_lb_target_group" "production_ms_tg" {
    name = "tc-production-ms-tg"
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
        Name = "tc-production-ms-tg"
    }

    depends_on = [ aws_vpc.main_vpc ]
}