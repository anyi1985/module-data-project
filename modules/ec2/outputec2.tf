output "Instance_Mods3DB_IP" {
  value = aws_instance.Instance_Mods3DB.public_ip
}

output "Instance_Mods3DB_ARN" {
  value = aws_instance.Instance_Mods3DB.arn
}
