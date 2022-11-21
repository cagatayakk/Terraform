resource "aws_launch_configuration" "my_LC" {
  name                        = "my_LC"
  image_id                    = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  key_name                    = "First_Key"
  security_groups             = [aws_security_group.sg_ec2.id]
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")

  lifecycle {
    create_before_destroy = true
  }

}
