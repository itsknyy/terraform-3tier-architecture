output "db_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.rds.endpoint
}

output "db_sg_id" {
  description = "DB security group ID"
  value       = aws_security_group.db_sg.id
}
