## ECS Cluster
data "aws_ssm_parameter" "ecs_cluster_name" {
  name = "/linuxtips-tf-final/ecs-cluster/cluster_1/name"
}

## VPC
data "aws_ssm_parameter" "vpc_id" {
  name = "/linuxtips-tf-final/vpc/vpc_id"
}

