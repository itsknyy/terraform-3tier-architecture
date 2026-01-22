variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_db_subnet_ids" {
  description = "Private DB subnets in two AZs"
  type        = list(string)
}

variable "app_sg_id" {
  description = "Security group ID of App EC2"
  type        = string
}

variable "db_username" {
  description = "RDS master username"
  type        = string
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}
