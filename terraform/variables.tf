variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "origoss-cluster"
}

variable "image" {
  description = "Docker image to deploy"
  type        = string
  default     = "ghcr.io/kovyd20/origoss-hello-world-go:latest"
}

variable "replicas" {
  description = "Number of pod replicas"
  type        = number
  default     = 1
}
