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
      PORT = 3000
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

