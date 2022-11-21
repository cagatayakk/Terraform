resource "aws_autoscaling_policy" "my_policy_up" {
  name                   = "my_policy_up"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
}

resource "aws_cloudwatch_metric_alarm" "my_cpu_alarm_up" {
  alarm_name          = "my_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "60"
  alarm_description   = "This metric monitors ec2 cpu utilization"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.my_policy_up.arn]
}

resource "aws_autoscaling_policy" "my_policy_down" {
  name                   = "my_policy_down"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.my_asg.name
}

resource "aws_cloudwatch_metric_alarm" "my_cpu_alarm_down" {
  alarm_name          = "my_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  alarm_description   = "This metric monitors ec2 cpu utilization"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg.name
  }

  alarm_actions = [aws_autoscaling_policy.my_policy_down.arn]
}