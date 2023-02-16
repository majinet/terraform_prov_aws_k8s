resource "aws_security_group" "worker_nodes" {
  name        = "allow_tls_worker_nodes"
  description = "Allow TLS inbound traffic for worker nodes"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Kubelet API"
    from_port        = 10250
    to_port          = 10250
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "NodePort Services"
    from_port        = 30000
    to_port          = 32767
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group for Kubernetes Worker nodes"
  }
}