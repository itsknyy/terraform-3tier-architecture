# VPC CIDR

variable "vpc_cidr" {
    description = "CIDR block for VPC"
    type        = string
    default     = "10.0.0.0/16"

    validation {
        condition     = contains(["10.0.0.0/16","172.31.0.0/16","192.168.0.0/16"], var.vpc_cidr)
        error_message = "vpc_cidr must be one of the approved CIDR blocks."
    }
}

variable "az" {
    description = "Primary availability zone"
    type        = string
}

variable "az_b" {
  description = "Secondary availability zone for db-b"
  type        = string
}


