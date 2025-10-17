provider "aws" {
  region = var.aws_region
}

# 1️⃣ Create ECR repository
resource "aws_ecr_repository" "java_app_repo" {
  name = var.ecr_repo_name
}

# 2️⃣ Security group for EC2
resource "aws_security_group" "allow_ssh_http" {
  name        = var.security_group_name
  description = "Allow SSH and HTTP inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 3️⃣ EC2 instance to run Docker container
resource "aws_instance" "java_app" {
  ami           = "ami-0dee22c13ea7a9a67" # Amazon Linux 2 for ap-south-1
  instance_type = var.instance_type
  key_name      = var.key_name
  security_groups = [aws_security_group.allow_ssh_http.name]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker awscli
    systemctl enable docker
    systemctl start docker
    $(aws ecr get-login --no-include-email --region ${var.aws_region})
    docker pull ${aws_ecr_repository.java_app_repo.repository_url}:latest
    docker run -d -p 80:8080 ${aws_ecr_repository.java_app_repo.repository_url}:latest
  EOF

  tags = {
    Name = "JavaAppEC2"
  }
}
