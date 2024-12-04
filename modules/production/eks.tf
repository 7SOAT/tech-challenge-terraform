resource "aws_eks_cluster" "production_ms_cluster" {
  name = "production-ms-cluster"
  role_arn = var.aws_iam_labrole_arn

  vpc_config {
    subnet_ids = aws_subnet.private_subnet[*].id
    security_group_ids = [aws_security_group.eks_sg.id]
  }

  depends_on = [
    aws_subnet.private_subnet,
    aws_security_group.eks_sg
  ]
}

resource "aws_eks_node_group" "production_ms_nodes" {
  cluster_name = aws_eks_cluster.production_ms_cluster.name
  node_group_name = "production-ms-group"
  node_role_arn = var.aws_iam_labrole_arn
  subnet_ids = aws_subnet.private_subnet[*].id

  scaling_config {
    desired_size = 1
    max_size = 1
    min_size = 1
  }

  instance_types = ["t2.micro"]
  disk_size = 20

  tags = {
    Name = "production-ms-node-group"
  }

  depends_on = [ 
    aws_eks_cluster.production_ms_cluster,
    aws_subnet.private_subnet
  ]
}