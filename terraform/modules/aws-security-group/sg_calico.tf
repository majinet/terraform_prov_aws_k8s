resource "aws_security_group" "calico" {
  name        = "allow_tls_for_calico"
  description = "Allow TLS inbound traffic for Calico"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Calico networking (BGP)"
    from_port        = 179
    to_port          = 179
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Calico networking with IP-in-IP enabled (default)"
    from_port        = 4
    to_port          = 4
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Calico networking with VXLAN enabled"
    from_port        = 4789
    to_port          = 4789
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Calico networking with Typha enabled"
    from_port        = 5473
    to_port          = 5473
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Calico networking with IPv4 Wireguard enabled"
    from_port        = 51820
    to_port          = 51820
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Calico networking with IPv6 Wireguard enabled"
    from_port        = 51821
    to_port          = 51821
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Calico networking (BGP)"
    from_port        = 179
    to_port          = 179
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Calico networking with IP-in-IP enabled (default)"
    from_port        = 4
    to_port          = 4
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Calico networking with VXLAN enabled"
    from_port        = 4789
    to_port          = 4789
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Calico networking with IPv4 Wireguard enabled"
    from_port        = 51820
    to_port          = 51820
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "Calico networking with IPv6 Wireguard enabled"
    from_port        = 51821
    to_port          = 51821
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group for Calico"
  }
}