output "node_private_ips" {
  value = data.aws_instances.main_eks_nodes.private_ips
}