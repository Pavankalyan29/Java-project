output "instance_public_ip" {
  value = aws_instance.app_instance.public_ip
}

output "security_group_id" {
  value = aws_security_group.app_sg.id
}
