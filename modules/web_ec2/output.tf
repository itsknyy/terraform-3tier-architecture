output "web_instance_id" {
    description = "Instance ID of the web ec2"
    value       = aws_instance.web_instance.id 
}

output "web_instance_sg_id" {
    description = "SG ID of the web ec2"
    value       = aws_security_group.web_sg.id
}

output "web_instance_public_ip" {
    description = "Public IP of the web instance"
    value       = aws_instance.web_instance.public_ip
}