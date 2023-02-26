terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-remote-state-demo2"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-remote-state"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"

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

resource "aws_spot_instance_request" "control_plane" {
  ami                    = "ami-0b828c1c5ac3f13ee"
  spot_price             = 0.12
  instance_type          = "r5a.large"
  spot_type              = "one-time"
  block_duration_minutes = 180
  wait_for_fulfillment   = "true"

  subnet_id     = module.aws_networks.subnet_1_id
  associate_public_ip_address = true
  key_name = "terraform-ec2"
  security_groups = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

  root_block_device {
    volume_type = "gp3"
    volume_size = 50
    delete_on_termination = true
  }

  tags = {
    Name = "Kubernetes control plane instance"
  }
}

#resource "aws_instance" "control_plane" {
#  ami           = "ami-0b828c1c5ac3f13ee"
#  instance_type = "r5a.large"
#  subnet_id     = module.aws_networks.subnet_1_id
#  associate_public_ip_address = true
#  key_name = "terraform-ec2"
#  security_groups = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

#  root_block_device {
#    volume_type = "gp2"
#    volume_size = 50
#    delete_on_termination = true
#  }

#  tags = {
#    Name = "Kubernetes control plane instance"
#  }
#}

#resource "aws_instance" "worker" {
#  ami           = "ami-0b828c1c5ac3f13ee"  ami-0fa715233bba2f42e
#  instance_type = "t2.micro"
#  subnet_id     = module.aws_networks.subnet_2_id
#  associate_public_ip_address = true
#  key_name = "terraform-ec2"
#  security_groups = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

#  root_block_device {
#    volume_type = "gp2"
#    volume_size = 1
#    delete_on_termination = true
#  }

#  tags = {
#    Name = "Kubernetes worker instance"
#  }
#}
