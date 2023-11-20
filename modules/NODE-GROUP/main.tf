# Resource: aws_eks_node_group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group

resource "aws_eks_node_group" "nodes_general" {
  # Name of the EKS Cluster.
  cluster_name = var.eks_cluster_name

  # Name of the EKS Node Group.
  node_group_name = "${var.eks_cluster_name}-ng"

  # Amazon Resource Name (ARN) of the IAM Role that provides permissions for the EKS Node Group.
  node_role_arn = var.node_group_arn

  # Identifiers of EC2 Subnets to associate with the EKS Node Group. 
  # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME 
  # (where CLUSTER_NAME is replaced with the name of the EKS Cluster).
  subnet_ids = [
    var.PRI_SUB_3_A_ID,
    var.PRI_SUB_4_B_ID
  ]

  # Configuration block with scaling settings
  scaling_config {
    # Desired number of worker nodes.
    desired_size = 2

    # Maximum number of worker nodes.
    max_size = 2

    # Minimum number of worker nodes.
    min_size = 2
  }

  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group.
  # Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64
  ami_type = "AL2_x86_64"

  # Type of capacity associated with the EKS Node Group. 
  # Valid values: ON_DEMAND, SPOT
  capacity_type = "ON_DEMAND"

  # Disk size in GiB for worker nodes
  disk_size = 20

  # Force version update if existing pods are unable to be drained due to a pod disruption budget issue.
  force_update_version = false

  # List of instance types associated with the EKS Node Group
  instance_types = ["t3.small"]

  labels = {
    role = "${var.eks_cluster_name}-Node-group-role",
    name = "${var.eks_cluster_name}-NG"
  }

  # Kubernetes version
  version = "1.27"

}