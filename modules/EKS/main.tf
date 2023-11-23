resource "aws_eks_cluster" "eks" {
  #Cluster Name
  name = var.PROJECT_NAME

  role_arn = var.eks_cluster_arn

  #K8S master version
  version = "1.27"

  vpc_config {
    #Indicate whether or not the amazon EKS private API server enpoint is enabled
    endpoint_private_access = false

    #Indicate whether or not the amazon EKS private API server enpoint is enabled
    endpoint_public_access = true

    #Must be at least 2 different AZ
    subnet_ids = [
        var.PUB_SUB_1_A_ID,
        var.PUB_SUB_2_B_ID,
        var.PRI_SUB_3_A_ID,
        var.PRI_SUB_4_B_ID
    ]

  }

}