terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-health-app-2026"

  tags = {
    Name        = "my-project-bucket"
    Environment = "dev"
  }
}

resource "aws_security_group" "app_sg" {
  name        = "health-app-sg"
  description = "Allow web and SSH traffic"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_instance" "app_server" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y docker
    service docker start
    docker run -d -p 5000:5000 animeluverx97/my-health-app
  EOF

  tags = {
    Name = "health-app-server"
  }
}

output "app_url" {
  value = "http://${aws_instance.app_server.public_ip}:5000/health"
}