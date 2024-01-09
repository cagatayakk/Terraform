variable "sg-ports" {
  default = [80, 22, 443]
}

resource "aws_security_group" "sg_ec2" {
  name        = "sg_ec2"
  dynamic "ingress" {
    for_each = var.sg-ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
 egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  description = "Allow SSH,HTTP,HTTPS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "sg_ec2"
  }
}
