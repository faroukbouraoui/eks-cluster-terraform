provider "aws" {
    access_key = "${var.AWS_ACCESS_KEY}"
    secret_key = "${var.AWS_SECRET_KEY}"
    token = "${var.AWS_SESSION_TOKEN}"
    region = "${var.region}"
  
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "training"
  role_arn = "arn:aws:iam::809977396697:role/LabRole"
  
  vpc_config {
    subnet_ids = ["subnet-0c3d947733965f47f","subnet-0fcb1805e85b56b96","subnet-061786a675090b800"]
  }

  depends_on = []
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "nodes"
  node_role_arn   = "arn:aws:iam::809977396697:role/LabRole"

  subnet_ids = ["subnet-0c3d947733965f47f","subnet-0fcb1805e85b56b96","subnet-061786a675090b800"]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}