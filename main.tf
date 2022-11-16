terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "my_vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.my_vpc.vpc_id}"
  subnet_cidr = "192.168.1.0/24"
}

module "my_ec2" {
  source        = "./modules/ec2"
  ec2_count     = 1
  ami_id        = "ami-0e6329e222e662a52"
  instance_type = "t2.micro"
  subnet_id     = "${module.my_vpc.subnet_id}"
}
