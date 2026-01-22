variable "vpc_id" {
    description = "VPC ID"
    type        = string
}

variable "public_subnet_web_id" {
    description = "Subnet for the web(frontend)"
    type        = string
}

variable "instance_type" {
    description = "Instance Type"
    type        = string
}

variable "key_name" {
    description = "Key used to ssh the instance"
    type        = string
}

variable "allowed_ssh_cidr" {
    description = "SSH is allowed from ..."
    type        = string
    default     = "0.0.0.0/0"
}