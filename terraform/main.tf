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

  shared_config_files      = ["/home/majinet/.aws/conf"]
  shared_credentials_files = ["/home/majinet/.aws/credentials"]
  profile                  = "TERRAFORM_ACCESS"
}

resource "aws_instance" "control_plane" {
  ami           = "ami-0b828c1c5ac3f13ee"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.kubernetes_subnet_1.id
  associate_public_ip_address = true
  key_name = "terraform-ec2"
  security_groups = [aws_security_group.allow_tls.id]

  tags = {
    Name = "Kubernetes control plane instance"
  }
}

resource "aws_instance" "worker" {
  ami           = "ami-0b828c1c5ac3f13ee"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.kubernetes_subnet_2.id
  associate_public_ip_address = true
  key_name = "terraform-ec2"
  security_groups = [aws_security_group.allow_tls.id]

  tags = {
    Name = "Kubernetes worker instance"
  }
}