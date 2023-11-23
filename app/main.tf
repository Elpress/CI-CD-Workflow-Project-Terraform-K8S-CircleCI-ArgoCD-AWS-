# creating VPC
module "VPC" {
  source           = "../modules/vpc"
  region           = var.REGION
  PROJECT_NAME     = var.PROJECT_NAMES
  vpc_cidr         = var.VPC_CIDR
  PUB_SUB_1_A_CIDR = var.PUB_SUB_1_A_CIDR
  PUB_SUB_2_B_CIDR = var.PUB_SUB_2_B_CIDR
  PRI_SUB_3_A_CIDR = var.PRI_SUB_3_A_CIDR
  PRI_SUB_4_B_CIDR = var.PRI_SUB_4_B_CIDR
}

# cretea NAT-NAT-GW
module "NAT-GW" {
  source = "../modules/nat-gw"

  PUB_SUB_1_A_ID = module.VPC.PUB_SUB_1_A_ID
  IGW_ID         = module.VPC.IGW_ID
  PUB_SUB_2_B_ID = module.VPC.PUB_SUB_2_B_ID
  VPC_ID         = module.VPC.VPC_ID
  PRI_SUB_3_A_ID = module.VPC.PRI_SUB_3_A_ID
  PRI_SUB_4_B_ID = module.VPC.PRI_SUB_4_B_ID
}


module "IAM" {
  source       = "../modules/IAM"
  PROJECT_NAME = var.PROJECT_NAMES
}

module "EKS" {
  source          = "../modules/EKS"
  PROJECT_NAME    = var.PROJECT_NAMES
  eks_cluster_arn = module.IAM.eks_cluster_arn
  PUB_SUB_1_A_ID  = module.VPC.PUB_SUB_1_A_ID
  PUB_SUB_2_B_ID  = module.VPC.PUB_SUB_2_B_ID
  PRI_SUB_3_A_ID  = module.VPC.PRI_SUB_3_A_ID
  PRI_SUB_4_B_ID  = module.VPC.PRI_SUB_4_B_ID
}

module "NODE-GROUP" {
  source           = "../modules/NODE-GROUP"
  eks_cluster_name = module.EKS.eks_cluster_name
  node_group_arn   = module.IAM.node_group_role_arn
  PRI_SUB_3_A_ID   = module.VPC.PRI_SUB_3_A_ID
  PRI_SUB_4_B_ID   = module.VPC.PRI_SUB_4_B_ID
}