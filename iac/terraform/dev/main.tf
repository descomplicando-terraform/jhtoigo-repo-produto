module "ecs_service" {
  source       = "git@github.com:jhtoigo/terraform-aws-service.git?ref=v1.0.0"
  name         = "produto"
  project_name = "linuxtips-tf-final"
  environment  = "dev"
  resource_tags = {
    Environment = "dev"
  }
  ecs_cluster_name = data.aws_ssm_parameter.ecs_cluster_name.value
  postgres_egress  = true
  region           = "us-east-1"
  vpc_id           = data.aws_ssm_parameter.vpc_id.value
  container_port   = 3000
  container_cpu    = 1024
  container_memory = 2048
  container_environments = {
    PORT     = "3000"
    NODE_ENV = "dev"
  }
  container_secrets = {
    DATABASE_URL = "example"
  }
}
