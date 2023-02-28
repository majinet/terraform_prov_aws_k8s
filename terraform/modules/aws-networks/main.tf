resource "aws_vpc" "kubernetes_vpc" {
  cidr_block  = "172.30.0.0/16"

  tags = {
    Name = "Kubernetes VPC"
  }
}

resource "aws_subnet" "kubernetes_subnet_1" {
  vpc_id     = aws_vpc.kubernetes_vpc.id
  cidr_block = "172.30.0.0/20"

  tags = {
    Name = "Kubernetes Subnet 1"
  }
}

resource "aws_subnet" "kubernetes_subnet_2" {
  vpc_id     = aws_vpc.kubernetes_vpc.id
  cidr_block = "172.30.16.0/20"

  tags = {
    Name = "Kubernetes Subnet 2"
  }
}

resource "aws_subnet" "kubernetes_subnet_3" {
  vpc_id     = aws_vpc.kubernetes_vpc.id
  cidr_block = "172.30.32.0/20"

  tags = {
    Name = "Kubernetes Subnet 3"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.kubernetes_vpc.id

  tags = {
    Name = "Internet Gateway for Kubernetes"
  }
}

data "aws_route_table" "selected_route_table" {
  vpc_id = aws_vpc.kubernetes_vpc.id
}

resource "aws_route" "route" {
  route_table_id            = data.aws_route_table.selected_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}
