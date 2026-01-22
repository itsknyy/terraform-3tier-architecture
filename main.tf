terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  az   = var.az
  az_b = var.az_b
}

module "web_ec2" {
  source = "./modules/web_ec2"

  vpc_id               = module.vpc.vpc_id
  public_subnet_web_id = module.vpc.public_subnet_web.id

  instance_type = var.web_instance_type
  key_name      = var.key_name
}

module "app_ec2" {
  source = "./modules/app_ec2"

  vpc_id                = module.vpc.vpc_id
  private_subnet_app_id = module.vpc.private_subnet_app.id

  web_instance_sg_id = module.web_ec2.web_instance_sg_id

  instance_type = var.app_instance_type
}

module "rds" {
  source = "./modules/rds"

  vpc_id = module.vpc.vpc_id

  private_db_subnet_ids = [
    module.vpc.private_subnet_db.id,
    module.vpc.private_subnet_db_b.id
  ]

  app_sg_id   = module.app_ec2.app_instance_sg_id
  db_username = var.db_username
  db_password = var.db_password
}


