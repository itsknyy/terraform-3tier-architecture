output "app_instance_id" {
    description = "Instance ID of the app ec2"
    value       = aws_instance.app_instance.id
}

output "app_instance_sg_id" {
    description = "SG ID of the app ec2"
    value       = aws_security_group.app_sg.id
}

