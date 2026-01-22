variable "region" {
  description = "AWS-region"
  type        = string
  default     = "us-east-1"
}

variable "az" {
  description = "Primary availability zone"
  type        = string
  default     = "us-east-1a"
}

variable "az_b" {
  description = "Secondary availability zone for db-b"
  type        = string
  default     = "us-east-1b"
}

variable "web_instance_type" {
  description = "Instance type for web-ec2"
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name"
  type        = string
}

variable "app_instance_type" {
  description = "Instance type for app-ec2"
  type        = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}
