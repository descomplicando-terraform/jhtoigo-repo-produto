locals {
  region = "us-east-1"
  tags = {
    Project     = "inuxtips-descomplicando-terraform-ecs-app"
    Environment = "dev"
  }
  app = {
    name   = "repo_produto"
    port   = 3000
    cpu    = 256
    memory = 512
    environments = {
      PORT      = 3000
      BASE_PATH = "/test/"
    }

  }
}
module "ecr" {
  source         = "git@github.com:jhtoigo/terraform-aws-ecr.git"
  ecr_repository = local.app.name
}

module "ecs_task" {
  source = "git@github.com:jhtoigo/terraform-aws-ecs-task.git?ref=v1.1.0"

  task_name              = local.app.name
  region                 = local.region
  container_image        = module.ecr.ecr_repository_url
  container_name         = local.app.name
  container_port         = local.app.port
  container_cpu          = local.app.cpu
  container_memory       = local.app.memory
  container_environments = local.app.environments
  resource_tags          = local.tags
  log_group_ecs          = data.aws_ssm_parameter.ecs_log_group.value
}

module "ecs_service" {
  source = "git@github.com:jhtoigo/terraform-aws-ecs-service.git?ref=v1.1.1"

  service_name      = local.app.name
  container_name    = local.app.name
  container_port    = local.app.port
  capacity_provider = "FARGATE_SPOT"
  cluster_id        = data.aws_ssm_parameter.ecs_cluster_id.value
  ecs_cluster_name  = data.aws_ssm_parameter.ecs_cluster_name.value
  vpc_id            = data.aws_ssm_parameter.vpc_id.value
  namespace         = data.aws_ssm_parameter.namespace.value
  resource_tags     = local.tags

  subnets = [
    data.aws_ssm_parameter.private_subnets_1a.value,
    data.aws_ssm_parameter.private_subnets_1b.value,
    data.aws_ssm_parameter.private_subnets_1c.value
  ]
  ecs_task                        = module.ecs_task.task_definition_arn
  associate_alb                   = false
  load_balancer_arn               = data.aws_ssm_parameter.load_balancer_arn.value
  load_balancer_listener_arn      = data.aws_ssm_parameter.load_balancer_listener_arn.value
  load_balancer_listner_rule_path = ["/test"]

}
