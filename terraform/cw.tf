# CloudWatch Alarms for EC2 and RDS
resource "aws_cloudwatch_metric_alarm" "webserver_cpu" {
  alarm_name          = "webserver-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "Alarm when CPU exceeds 70% for 2 periods"
  dimensions = {
    InstanceId = aws_instance.webserver.id
  }
}

resource "aws_cloudwatch_metric_alarm" "database_storage" {
  alarm_name          = "database-storage"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "FreeStorageSpace"
  namespace           = "AWS/RDS"
  period              = "300"
  statistic           = "Average"
  threshold           = "1000000000"
  alarm_description   = "Alarm when database storage is less than 1GB for 2 periods"
  dimensions = {
    DBInstanceIdentifier = aws_db_instance.postgres.id
  }
}
