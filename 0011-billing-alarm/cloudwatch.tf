resource "aws_cloudwatch_metric_alarm" "billing" {
  alarm_name          = "Billing Alarm"
  alarm_description   = "It triggers when the threshold is >= ${var.threshold} ${var.currency}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "21600" # 6 hours
  statistic           = "Maximum"
  threshold           = var.threshold
  alarm_actions       = [aws_sns_topic.billing_alarm.arn]

  dimensions = {
    Currency = var.currency
  }
}
