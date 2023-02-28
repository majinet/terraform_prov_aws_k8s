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

data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_launch_template" "ec2_launch" {
  image_id    = data.aws_ami.ubuntu_ami.id
  key_name = "terraform-ec2"
  vpc_security_group_ids = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]
  ebs_optimized = true

  instance_requirements {
    memory_mib {
      min = 16384
      max = 65536
    }

    vcpu_count {
      min = 2
      max = 4
    }

    instance_generations = ["current"]
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  block_device_mappings {

    device_name = data.aws_ami.ubuntu_ami.root_device_name

    ebs {
      volume_type = "gp3"
      volume_size = 50
      delete_on_termination = true
    }
  }
}

/*
resource "aws_ec2_fleet" "control_plane" {

  launch_template_config {
    launch_template_specification {
      launch_template_id = aws_launch_template.ec2_launch.id
      version            = aws_launch_template.ec2_launch.latest_version
    }

    override {
      max_price = "0.2"
    }
  }

  target_capacity_specification {
    default_target_capacity_type = "spot"
    total_target_capacity        = 1
  }

  spot_options {
      allocation_strategy     = "price-capacity-optimized"

  }
}
*/

/*
resource "aws_instance" "control_plane" {
  ami           = "ami-09cd747c78a9add63"
  instance_type = "r5a.xlarge"
  subnet_id     = module.aws_networks.subnet_1_id
  associate_public_ip_address = true
  key_name = "terraform-ec2"
  security_groups = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

  root_block_device {
    volume_type = "gp3"
    volume_size = 40
    delete_on_termination = true
  }

  tags = {
    Name = "Kubernetes control plane instance"
  }
}
*/

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
