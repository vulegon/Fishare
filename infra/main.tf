module "iam" {
  source = "./modules/iam"
  product_name = var.product_name
  env = var.env
}

module "s3" {
  source = "./modules/s3"
  product_name = var.product_name
  env = var.env
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  name = "${var.env}-${var.product_name}-vpc"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
  name = "${var.env}-${var.product_name}"
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  target_availability_zones = [var.tokyo_availability_zone, var.osaka_availability_zone]
}

# module "elastic_ip" {
#   source = "./modules/elastic_ip"
#   env = var.env
#   product_name = var.product_name
#   nat_instance_id = module.ec2.nat_instance_id
# }

# module "ec2" {
#   source = "./modules/ec2"
#   env = var.env
#   product_name = var.product_name
#   nat_ami = "ami-0c3fd0f5d33134a76" # Amazon Linux 2
#   nat_instance_type = "t2.micro"
#   public_subnet_id = module.subnet.public_subnet_ids[0]
#   nat_security_group_ids = [module.security_group.nat_instance_sg_id]
# }

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
  env = var.env
  product_name = var.product_name
}

module "route_table" {
  source = "./modules/route_table"
  vpc_id = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  env = var.env
  product_name = var.product_name
  public_subnet_ids = module.subnet.public_subnet_ids
  private_subnet_id = module.subnet.private_subnet_ids[0]
  # nat_instance_network_interface_id = module.ec2.nat_instance_network_interface_id
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
  env = var.env
  product_name = var.product_name
  my_ips = ["59.156.50.156/32"]
  private_subnet_cidr = var.private_subnet_cidrs[0]
}

module "subnet_group" {
  source = "./modules/subnet_group"
  env = var.env
  product_name = var.product_name
  private_subnet_ids = module.subnet.private_subnet_ids
}

module "route_53" {
  source = "./modules/route_53"
  product_name = var.product_name
  env = var.env
  domain_name = var.domain_name
  ttl = 300
  domain_validation_options = module.acm.domain_validation_options
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
}

# ACMの証明書を作成するためのコード。
module "acm" {
  source = "./modules/acm"
  product_name = var.product_name
  env = var.env
  domain_name = var.domain_name
  validation_record_fqdns = module.route_53.validation_record_fqdns
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  env = var.env
  product_name = var.product_name
  api_alb_sg_ids = [module.security_group.api_alb_id]
  front_alb_sg_ids = [module.security_group.front_alb_id]
  public_subnet_ids = module.subnet.public_subnet_ids
  front_certificate_arn = module.acm.front_certificate_arn
  api_certificate_arn = module.acm.api_certificate_arn
}

module "rds" {
  source = "./modules/rds"
  env = var.env
  product_name = var.product_name
  db_username = data.aws_ssm_parameter.postgres_user.value
  db_password = data.aws_ssm_parameter.postgres_password.value
  subnet_group_name = module.subnet_group.rds_subnet_group_name
  vpc_security_group_ids = [module.security_group.rds_sg_id]
  availability_zone = var.tokyo_availability_zone
}

module "ecr" {
  source = "./modules/ecr"
  product_name = var.product_name
  env = var.env
}

module "ecs" {
  source = "./modules/ecs"
  product_name = var.product_name
  env = var.env
  desired_count = 1 # 個人開発のため、最小構成で構築。本番環境では適切な数を設定すること。
  api_service_security_group_ids = [module.security_group.api_service_id]
  front_service_security_group_ids = [module.security_group.front_service_id]
  redis_service_security_group_ids = [module.security_group.redis_service_id]
  sidekiq_service_security_group_ids = [module.security_group.sidekiq_service_id]
  public_subnet_ids = module.subnet.public_subnet_ids
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role_arn
  ecs_task_role_arn = module.iam.ecs_task_role_arn
  api_repository_url = module.ecr.api_repository_url
  front_repository_url = module.ecr.front_repository_url
  redis_repository_url = module.ecr.redis_repository_url
  api_ecs_log_group_name = module.cloudwatch.api_ecs_log_group_name
  front_ecs_log_group_name = module.cloudwatch.front_ecs_log_group_name
  redis_ecs_log_group_name = module.cloudwatch.redis_ecs_log_group_name
  sidekiq_ecs_log_group_name = module.cloudwatch.sidekiq_ecs_log_group_name
  api_alb_target_group_arn = module.alb.api_alb_target_group_arn
  front_alb_target_group_arn = module.alb.front_alb_target_group_arn
  api_rails_master_key_arn = data.aws_ssm_parameter.rails_master_key.arn
}

module "cloudwatch" {
  source = "./modules/cloud_watch"
  product_name = var.product_name
  env = var.env
}
