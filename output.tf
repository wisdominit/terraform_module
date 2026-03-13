output "aws_instance_ip_address" {
  value = aws_instance.my_terra_instance.public_ip
  description = "public ip of the instance"
}

output "security_group_id" {
  value = aws_security_group.my_terra_group.id
  description = "security group id"
}

output "security_group_ingress" {
  value = aws_security_group.my_terra_group.ingress
  description = "ingress rules"
}

output "vpc_id" {
  value = aws_vpc.terra_vpc.id
  description = "vpc id"
}
