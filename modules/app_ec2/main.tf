data "aws_ami" "amazon_linux_ami" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values =  ["al2023-ami-*-x86_64"]
    }

      filter {
    name   = "virtualization-type"
    values = ["hvm"]
    }
}

resource "aws_security_group" "app_sg" {
    name            = "app_sg"
    description     = "Allow traffic from web-ec2"
    vpc_id          = var.vpc_id

    ingress {
        description      = "web-ec2 traffic"
        from_port        = 8080
        to_port          = 8080
        protocol         = "tcp"
        security_groups  = [var.web_instance_sg_id] 
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "app_instance" {
    ami                             = data.aws_ami.amazon_linux_ami.id
    instance_type                   = var.instance_type
    subnet_id                       = var.private_subnet_app_id
    vpc_security_group_ids          = [aws_security_group.app_sg.id]

    tags = {
        Name = "three-tier-app-ec2"
    }
}