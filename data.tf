data "aws_instances" "main_eks_nodes" {
  filter {
    name   = "tag:eks:cluster-name"
    values = ["tech-challenge-monolith"]
  }
}

data "aws_ami" "eks_worker" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-eks-node-*"]  # Padrão para AMIs dos EKS Worker Nodes
  }
}