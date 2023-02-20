resource "aws_security_group" "control_plane" {
  name        = "allow_tls_control_plane"
  description = "Allow TLS inbound traffic for control_plane"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Kubernetes API server"
    from_port        = 6443
    to_port          = 6443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "etcd server client API"
    from_port        = 2379
    to_port          = 2380
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Kubelet API"
    from_port        = 10250
    to_port          = 10250
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "kube-scheduler"
    from_port        = 10259
    to_port          = 10259
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "kube-controller-manager"
    from_port        = 10257
    to_port          = 10257
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "NFS share"
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Metric Server"
    from_port        = 4443
    to_port          = 4443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Metric State Server"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Node Exporter"
    from_port        = 9100
    to_port          = 9100
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Prometheus Alert manager"
    from_port        = 9093
    to_port          = 9093
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Group for Kubernetes Control Plane"
  }
}