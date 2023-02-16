terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-northeast-1"

  shared_config_files      = ["~/.aws/conf"]
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "TERRAFORM_ACCESS"
}

module "aws_networks" {
  source = "./modules/aws-networks"
}

module "aws_security_group" {
  source = "./modules/aws-security-group"

  vpc_id = module.aws_networks.vpc_id
}

resource "aws_instance" "control_plane" {
  ami           = "ami-0b828c1c5ac3f13ee"
  instance_type = "t2.micro"
  subnet_id     = module.aws_networks.subnet_1_id
  associate_public_ip_address = true
  key_name = "terraform-ec2"
  security_groups = [module.aws_security_group.sg_1, module.aws_security_group.sg_control_plane_id]

  tags = {
    Name = "Kubernetes control plane instance"
  }
}

resource "aws_instance" "worker" {
  ami           = "ami-0b828c1c5ac3f13ee"
  instance_type = "t2.micro"
  subnet_id     = module.aws_networks.subnet_2_id
  associate_public_ip_address = true
  key_name = "terraform-ec2"
  security_groups = [module.aws_security_group.sg_1, module.aws_security_group.sg_worker_nodes_id]

  tags = {
    Name = "Kubernetes worker instance"
  }
}
