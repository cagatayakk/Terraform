resource "aws_launch_template" "my_LT" {
  name                        = "my_LT"
  image_id                    = "ami-0b0dcb5067f052a63"
  instance_type               = "t2.micro"
  key_name                    = "First_Key"
  vpc_security_group_ids      = [aws_security_group.sg_ec2.id]
  user_data                   = filebase64("userdata.sh")

}
