output "vpc_cidr" {
    description = "CIDR of the VPC"
    value       = var.vpc_cidr
}

output "vpc_id" {
    description = "VPC ID"
    value       = aws_vpc.main_vpc.id
}

output "public_subnet_web" {
    value = {
        id      = aws_subnet.public_subnet_web.id
        cidr    = aws_subnet.public_subnet_web.cidr_block
        az      = aws_subnet.public_subnet_web.availability_zone
    }
}

output "private_subnet_app" {
    value = {
        id      = aws_subnet.private_subnet_app.id
        cidr    = aws_subnet.private_subnet_app.cidr_block
        az      = aws_subnet.private_subnet_app.availability_zone
    }
}

output "private_subnet_db" {
    value = {
        id      = aws_subnet.private_subnet_db.id
        cidr    = aws_subnet.private_subnet_db.cidr_block
        az      = aws_subnet.private_subnet_db.availability_zone        
    }
}

output "private_subnet_db_b" {
    value = {
        id      = aws_subnet.private_subnet_db_b.id
        cidr    = aws_subnet.private_subnet_db_b.cidr_block
        az      = aws_subnet.private_subnet_db_b.availability_zone        
    }
}

output "eip" {
    description = "Elastic IP for NAT gateway"
    value       = aws_eip.nat_eip.id
}