
# Define CloudWatch alarm for application health monitoring
resource "aws_cloudwatch_metric_alarm" "application_health_alarm" {
  alarm_name          = "ApplicationHealthAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when CPU utilization exceeds 80%"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }
  alarm_actions = [aws_sns_topic.example.arn]
}


# Define CloudWatch alarm for instance termination event
resource "aws_cloudwatch_metric_alarm" "instance_termination_alarm" {
  alarm_name          = "InstanceTerminationAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "GroupTotalInstances"
  namespace           = "AWS/AutoScaling"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "Alarm when an instance terminates"
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.web.name
  }
  alarm_actions = [aws_sns_topic.example.arn]
}

# Define CloudWatch alarm for instance health check failures
resource "aws_cloudwatch_metric_alarm" "instance_health_alarm" {
  alarm_name          = "InstanceHealthAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/ELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Alarm when an instance becomes unhealthy"
  dimensions = {
    LoadBalancerName = aws_lb.web.name
  }
  alarm_actions = [aws_sns_topic.example.arn]
}

#CloudWatch alarm for instance within the target groups associated with the ELB becomes unhealthy
resource "aws_cloudwatch_metric_alarm" "unhealthy_instance_alarm" {
  alarm_name          = "UnhealthyInstanceAlarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Alarm when any instance becomes unhealthy in target groups"
  dimensions = {
    LoadBalancer = aws_lb.web.arn
  }
  alarm_actions = [aws_sns_topic.example.arn]
}
