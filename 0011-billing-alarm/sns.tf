resource "aws_sns_topic" "billing_alarm" {
  name = "billing-alarm-notification"
}

resource "aws_sns_topic_subscription" "billing_alarm_email_target" {
  topic_arn = aws_sns_topic.billing_alarm.arn
  protocol  = "email"
  endpoint  = var.email
}
