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
  user_data = <<EOF
#!/bin/bash
yum update -y
yum install httpd -y
FOLDER="https://raw.githubusercontent.com/cagatayakk/AWS_Projects/main/Project-101-kittens-carousel-static-website-ec2/static-web"
cd /var/www/html
wget $FOLDER/index.html
wget $FOLDER/cat0.jpg
wget $FOLDER/cat1.jpg
wget $FOLDER/cat2.jpg
wget $FOLDER/cat3.png
systemctl start httpd
systemctl enable httpd
EOF
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