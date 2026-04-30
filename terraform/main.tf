data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "origoss-vpc"
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, 2)
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags  = { "kubernetes.io/role/elb" = 1 }
  private_subnet_tags = { "kubernetes.io/role/internal-elb" = 1 }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.32"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    default = {
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
  }
}

resource "kubernetes_deployment" "hello_world" {
  metadata {
    name = "hello-world"
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = { app = "hello-world" }
    }

    template {
      metadata {
        labels = { app = "hello-world" }
      }

      spec {
        container {
          name  = "hello-world"
          image = var.image

          port {
            container_port = 3000
          }

          resources {
            requests = { cpu = "50m", memory = "64Mi" }
            limits   = { cpu = "100m", memory = "128Mi" }
          }
        }
      }
    }
  }

  depends_on = [module.eks]
}

resource "kubernetes_service" "hello_world" {
  metadata {
    name = "hello-world"
  }

  spec {
    selector = { app = "hello-world" }
    type     = "LoadBalancer"

    port {
      port        = 80
      target_port = 3000
    }
  }

  depends_on = [module.eks]
}
