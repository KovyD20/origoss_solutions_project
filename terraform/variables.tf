variable "image" {
  description = "Docker image to deploy"
  type        = string
  default     = "ghcr.io/kovyd20/origoss_solutions_project:latest"
}

variable "replicas" {
  description = "Number of pod replicas"
  type        = number
  default     = 1
}
