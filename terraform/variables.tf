# General Variables
variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "ap-southeast-1"
}

# EC2 Variables
variable "ami" {
  description = "Amazon machine image to use for ec2 instance"
  type        = string
  default     = "ami-0075a67de5ab4fa5e" # AMI for Ubuntu 18.04 LTS
}

variable "instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of key pair to use for ec2 instance"
  type        = string
}

# RDS Variables
variable "db_name" {
  description = "Name of DB"
  type        = string
}

variable "db_user" {
  description = "Username for DB"
  type        = string
}

variable "db_pass" {
  description = "Password for DB"
  type        = string
  sensitive   = true
}
