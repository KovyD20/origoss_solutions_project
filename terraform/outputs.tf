output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "load_balancer_hostname" {
  value = kubernetes_service.hello_world.status[0].load_balancer[0].ingress[0].hostname
}
