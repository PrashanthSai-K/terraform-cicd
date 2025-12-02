variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance to launch."
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for the EC2 instances."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the existing VPC."
  type        = string
}
