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

resource "aws_spot_fleet_request" "control_plane" {
  iam_fleet_role          = "arn:aws:iam::404886641986:role/aws-ec2-spot-fleet-tagging-role"
  target_capacity         = 1
  spot_price              = 0.2
  wait_for_fulfillment    = "true"
  allocation_strategy     = "lowestPrice"
  fleet_type              = "request"
  valid_until             = "2023-02-26T20:44:20Z"

  launch_specification {
    ami               = "ami-0b828c1c5ac3f13ee"
    key_name          = "terraform-ec2"
    associate_public_ip_address = true

    vpc_security_group_ids = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

    root_block_device {
      volume_type = "gp3"
      volume_size = 50
      delete_on_termination = true
    }

    instance_requirements {
      memory_gib_per_vcpu {
        min = 8
        max = 8
      }

      vcpu_count {
        min = 4
        max = 4
      }
    }
  }

  launch_specification {
    instance_type     = "r5.xlarge"
    ami               = "ami-0b828c1c5ac3f13ee"
    key_name          = "terraform-ec2"
    associate_public_ip_address = true

    vpc_security_group_ids = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

    root_block_device {
      volume_type = "gp3"
      volume_size = 50
      delete_on_termination = true
    }
  }

  launch_specification {
    instance_type     = "r5.xlarge"
    ami               = "ami-0b828c1c5ac3f13ee"
    key_name          = "terraform-ec2"
    associate_public_ip_address = true

    vpc_security_group_ids = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

    root_block_device {
      volume_type = "gp3"
      volume_size = 50
      delete_on_termination = true
    }
  }

  launch_specification {
    instance_type     = "r6i.xlarge"
    ami               = "ami-0b828c1c5ac3f13ee"
    key_name          = "terraform-ec2"
    associate_public_ip_address = true

    vpc_security_group_ids = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

    root_block_device {
      volume_type = "gp3"
      volume_size = 50
      delete_on_termination = true
    }
  }

  launch_specification {
    instance_type     = "r5b.xlarge"
    ami               = "ami-0b828c1c5ac3f13ee"
    key_name          = "terraform-ec2"
    associate_public_ip_address = true

    vpc_security_group_ids = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

    root_block_device {
      volume_type = "gp3"
      volume_size = 50
      delete_on_termination = true
    }
  }

  launch_specification {
    instance_type     = "r5n.xlarge"
    ami               = "ami-0b828c1c5ac3f13ee"
    key_name          = "terraform-ec2"
    associate_public_ip_address = true

    vpc_security_group_ids = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

    root_block_device {
      volume_type = "gp3"
      volume_size = 50
      delete_on_termination = true
    }
  }

  launch_specification {
    instance_type     = "t3a.2xlarge"
    ami               = "ami-0b828c1c5ac3f13ee"
    key_name          = "terraform-ec2"
    associate_public_ip_address = true

    vpc_security_group_ids = [module.aws_security_group.sg_1, module.aws_security_group.sg_microk8s]

    root_block_device {
      volume_type = "gp3"
      volume_size = 50
      delete_on_termination = true
    }
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
#    volume_type = "gp3"
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
