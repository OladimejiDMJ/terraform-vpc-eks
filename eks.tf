provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-statging"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "test-eks"
  cluster_version = "1.17"
  subnets         = [aws_subnet.testvpc-public-1.id, aws_subnet.testvpc-private-1.id]
  vpc_id          = aws_vpc.testvpc.id

  node_groups = {
    public = {
      subnets          = [aws_subnet.testvpc-public-1.id]
      desired_capacity = 1
      max_capacity     = 10
      min_capacity     = 1

      instance_type = "t3a.large"
      k8s_labels = {
        Environment = "public"
      }
    }
    private = {
      subnets          = [aws_subnet.testvpc-private-1.id]
      desired_capacity = 1
      max_capacity     = 10
      min_capacity     = 1

      instance_type = "t3a.large"
      k8s_labels = {
        Environment = "private"
      }
    }
  }

}