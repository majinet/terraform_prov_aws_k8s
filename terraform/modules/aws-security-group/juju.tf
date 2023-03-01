resource "aws_security_group" "juju" {
  name        = "allow_tls_juju"
  description = "Allow TLS inbound traffic for juju"
  vpc_id      = var.vpc_id

  ingress {
    description      = "API"
    from_port        = 17070
    to_port          = 17071
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Juju agents for HTTPS"
    from_port        = 8443
    to_port          = 8443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "communication with the MAAS"
    from_port        = 9686
    to_port          = 9686
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group for juju"
  }
}