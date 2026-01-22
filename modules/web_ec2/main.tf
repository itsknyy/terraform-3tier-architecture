data "aws_ami" "amazon_linux_ami" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values = ["al2023-ami-*-x86_64"]
    }

    filter {
    name   = "virtualization-type"
    values = ["hvm"]
    }
}

resource "aws_security_group" "web_sg" {
    name            = "web-sg"
    description     = "Allow HTTP and SSH"
    vpc_id          = var.vpc_id

    ingress {
        description  = "HTTP"
        from_port    = 80
        to_port      = 80
        protocol     = "tcp"
        cidr_blocks  = ["0.0.0.0/0"]
    }

    ingress {
        description  = "HTTPS"
        from_port    = 443
        to_port      = 443
        protocol     = "tcp"
        cidr_blocks  = ["0.0.0.0/0"]
    }

    ingress {
        description  = "SSH"
        from_port    = 22
        to_port      = 22
        protocol     = "tcp"
        cidr_blocks  = [var.allowed_ssh_cidr]
    }

    egress {
        description  = "All outbound traffic"
        from_port    = 0
        to_port      = 0
        protocol     = "-1"
        cidr_blocks  = ["0.0.0.0/0"]
    }

    tags = {
        Name = "three-tier-web-sg"
    }
}

resource "aws_instance" "web_instance" {
    ami                              = data.aws_ami.amazon_linux_ami.id
    instance_type                    = var.instance_type
    subnet_id                        = var.public_subnet_web_id
    key_name                         = var.key_name
    vpc_security_group_ids           = [aws_security_group.web_sg.id] 
    associate_public_ip_address      = true

    tags = {
        Name = "three-tier-web-ec2"
    }
}



