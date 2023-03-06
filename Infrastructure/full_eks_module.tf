
# VPC module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.12.0"

  name = "amit-eks-vpc"

  cidr = "10.0.0.0/16" # Replace with your desired CIDR block

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"] # Replace with your desired AZs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] # Replace with your desired private subnets
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"] # Replace with your desired public subnets

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# EKS module
module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_id
  cluster_version = "1.24"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }


  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets


   # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    name = "amit-2-cluster-workers"
    instance_types = ["t2.medium"]
  }

  eks_managed_node_groups = {
    blue = {}
    workers = {
      min_size     = 2
      max_size     = 5
      desired_size = 2

      instance_types = ["t2.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }
   create_iam_role          = true
      iam_role_name            = "eks-managed-node-group-complete-example"
      iam_role_use_name_prefix = false
      iam_role_description     = "EKS managed node group complete example role"
      iam_role_tags = {
        Purpose = "Protector of the kubelet"
      }
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }

}
