variable "vpc_id" {
    description = "Vpc ID"
    type        = string
}

variable "private_subnet_app_id" {
    description = "Subnet for the app(backend)"
    type        = string
}

variable "instance_type" {
    description = "Instance type is the app-ec2"
    type        = string
}

variable "web_instance_sg_id"{
    type = string
}