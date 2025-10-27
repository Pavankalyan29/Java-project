# # Security Group
resource "aws_security_group" "app_sg" {
    name        = "asciisum-sg"
    description = "Allow HTTP traffic"

    ingress {
        from_port   = 8080
        to_port     = 8080
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

# Fetch the ECR repository and latest image
data "aws_ecr_repository" "asciisum" {
    name = "asciisum-app"
}

data "aws_ecr_image" "latest_image" {
    repository_name = data.aws_ecr_repository.asciisum.name
    most_recent     = true
}

# EC2 instance
resource "aws_instance" "app_instance" {
    ami           = "ami-00af95fa354fdb788"  # Amazon Linux 2
    instance_type = var.instance_type
    key_name      = var.key_name
    vpc_security_group_ids = [aws_security_group.app_sg.id]

    user_data = <<-EOF
    #!/bin/bash -ex
    yum update -y
    amazon-linux-extras install docker -y
    service docker start
    usermod -a -G docker ec2-user
    aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_ecr_repository.asciisum.repository_url}
    docker pull ${data.aws_ecr_image.latest_image.image_uri}
    docker run -d -p 8080:8080 ${data.aws_ecr_image.latest_image.image_uri}
    EOF

    tags = {
        Name = "AsciisumApp"
    }
}
