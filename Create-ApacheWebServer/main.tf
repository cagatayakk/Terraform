terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "linux" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = ["my-SecGrp"]
  tags = {
    "Name" = "Linux-ec2"
  }
  user_data = filebase64("user_data.sh")
}

resource "aws_security_group" "my-SecGrp" {
  name        = "my-SecGrp"
  description = "Allow HTTP and SSH traffic"

  ingress {
    description      = "HTTP Connection"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH Connection"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-SecGrp-tf"
  }
}

output "Public-URL" {
  value       = "http://${aws_instance.linux.public_ip}"
  description = "WebSite URL"
}
