resource "aws_autoscaling_group" "my_asg" {
  name                      = "my_asg"
  max_size                  = 3
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  target_group_arns         = [aws_lb_target_group.my_tg.arn]
  vpc_zone_identifier       = [aws_subnet.my_subnet_1.id, aws_subnet.my_subnet_2.id]
  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity",
  "GroupInServiceInstances", "GroupTotalInstances"]
  metrics_granularity = "1Minute"
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "my_asg"
    propagate_at_launch = true
  }
  launch_template {
    id = aws_launch_template.my_LT.id
    version = aws_launch_template.my_LT.latest_version
  }
}
