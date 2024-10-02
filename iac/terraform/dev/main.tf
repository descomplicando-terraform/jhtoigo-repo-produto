locals {
  app_name     = "produto"
  project_name = "linuxtips-tf-final"
  environment  = "dev"
  region       = "us-east-1"
  container_environments = {
    PORT      = "3000"
    NODE_ENV  = "dev"
    BASE_PATH = "/produto"

  }
  container_secrets = {
    PG_CONNECTION_STRING = "postgresql://postgres:senha123@postgres:5432/postgres"

  }
  tags = {
    Environment = "dev"
  }
}

module "ecs_service" {
  source                 = "git::https://github.com/jhtoigo/terraform-aws-service.git?ref=v1.1.2"
  name                   = local.app_name
  project_name           = local.project_name
  environment            = local.environment
  resource_tags          = local.tags
  ecs_cluster_name       = data.aws_ssm_parameter.ecs_cluster_name.value
  postgres_egress        = true
  region                 = local.region
  vpc_id                 = data.aws_ssm_parameter.vpc_id.value
  container_port         = 3000
  container_cpu          = 1024
  container_memory       = 2048
  container_environments = local.container_environments
  container_secrets      = local.container_secrets
}
