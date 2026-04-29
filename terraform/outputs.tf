output "service_name" {
  value = kubernetes_service.hello_world.metadata[0].name
}

output "node_port" {
  value = kubernetes_service.hello_world.spec[0].port[0].node_port
}
