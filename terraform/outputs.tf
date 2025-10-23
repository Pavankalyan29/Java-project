output "instance_public_ip" {
  description = "Public IP of the deployed EC2 instance"
  value       = aws_instance.app_instance.public_ip
}

output "security_group_id" {
  description = "Security Group ID created for the app"
  value       = aws_security_group.app_sg.id
}
