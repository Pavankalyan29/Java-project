variable "instance_type" {
  default = "t3.micro"
}

variable "key_name" {
  description = "Your AWS EC2 key pair name"
  type        = string
  default     = "jenkins-key" 
}

# variable "vpc_id" {
#   description = "VPC ID to launch EC2"
#   type        = string
# }
