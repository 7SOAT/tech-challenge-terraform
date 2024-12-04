resource "aws_security_group" "eks_sg" {
  name        = "EKS Cluster Security Group"
  description = "Security Group for EKS Cluster"
  vpc_id      = aws_vpc.main_vpc.id

  # Allow inbound traffic from the load balancer to the worker nodes
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"    
    security_groups = [aws_security_group.nlb_sg.id]
  }
  
  ingress {
    from_port   = 4000
    to_port     = 4000
    protocol    = "tcp"    
    security_groups = [aws_security_group.nlb_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-eks-cluster-sg"
  }

  depends_on = [
     aws_vpc.main_vpc, 
     aws_security_group.nlb_sg
  ]
}

resource "aws_security_group" "nlb_sg" {
  name        = "NLB Security Group"
  description = "Security Group for Network Load Balancer"
  vpc_id = aws_vpc.main_vpc.id

  # Allow inbound HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # Allow inbound HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 80
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port   = 443
    to_port     = 4000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  tags = {
    Name = "Network Load Balancer SG"
  }

  depends_on = [ aws_vpc.main_vpc ]
}

resource "aws_security_group" "api_gateway_sg" {
  name = "API Gateway Security Group"
  description = "Allow traffico from API Gateway to NLB"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.nlb_sg.id]
  }

  tags = {
    Name = "API Gateway Security Group"
  }

  depends_on = [ aws_security_group.nlb_sg ]
}

resource "aws_security_group" "rds_sg" {
  name = "RDS Security Group"
  description = "allow applications to connect into db instace"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    security_groups = [aws_security_group.eks_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS Security Group"
  }
}