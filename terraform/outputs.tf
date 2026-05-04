output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

data "kubernetes_service" "hello_world" {
  metadata {
    name      = "hello-world"
    namespace = "default"
  }
  depends_on = [kubernetes_manifest.service]
}

output "load_balancer_hostname" {
  value = data.kubernetes_service.hello_world.status.0.load_balancer.0.ingress.0.hostname
}
