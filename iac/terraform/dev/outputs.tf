output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = module.ecs_service.service_name
}

output "application_url" {
  description = "Load Balancer URL"
  value       = format("%s/%s", module.ecs_service.load_balancer_url, local.app_name)
}
