## ECS Cluster
data "aws_ssm_parameter" "ecs_cluster_name" {
  name = "/linuxtips-tf-final/ecs-cluster/cluster_1/name"
}

data "aws_ssm_parameter" "ecs_cluster_id" {
  name = "/linuxtips-tf-final/ecs-cluster/cluster_1/id"
}

data "aws_ssm_parameter" "ecs_log_group" {
  name = "/linuxtips-tf-final/ecs-log-group"
}

## VPC

data "aws_ssm_parameter" "vpc_id" {
  name = "/linuxtips-tf-final/vpc/vpc_id"
}

## Service Discovery

data "aws_ssm_parameter" "namespace" {
  name = "/linuxtips-tf-final/namespace"
}

## Load Balancer
data "aws_ssm_parameter" "load_balancer_arn" {
  name = "/linuxtips-tf-final/lb/arn"
}

data "aws_ssm_parameter" "load_balancer_listener_arn" {
  name = "/linuxtips-tf-final/lb/default_listener"
}

