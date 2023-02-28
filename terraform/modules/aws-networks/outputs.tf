output "vpc_id" {
  value = aws_vpc.kubernetes_vpc.id
}

/*
output "subnet_1_id" {
  value = aws_subnet.kubernetes_subnet_1.id
}

output "subnet_2_id" {
  value = aws_subnet.kubernetes_subnet_2.id
}

output "subnet_3_id" {
  value = aws_subnet.kubernetes_subnet_3.id
}
*/