output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "load_balancer_hostname" {
  value = kubernetes_manifest.service.object.status.loadBalancer.ingress[0].hostname
}
