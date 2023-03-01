output "sg_1" {
  value = aws_security_group.allow_tls.id
}

output "sg_control_plane_id" {
  value = aws_security_group.control_plane.id
}

output "sg_worker_nodes_id" {
  value = aws_security_group.worker_nodes.id
}

output "sg_calico_id" {
  value = aws_security_group.calico.id
}

output "sg_microk8s" {
  value = aws_security_group.microk8s.id
}

output "sg_juju" {
  value = aws_security_group.juju.id
}