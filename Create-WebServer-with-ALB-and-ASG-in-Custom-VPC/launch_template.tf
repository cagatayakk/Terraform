resource "aws_launch_template" "my_LT" {
  name                        = "my_LT"
  image_id                    = "ami-00b8917ae86a424c9"
  instance_type               = "t2.micro"
  key_name                    = "cagatayakk"
  vpc_security_group_ids      = [aws_security_group.sg_ec2.id]
  user_data                   = filebase64("userdata.sh")

}
