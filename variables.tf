variable "aws_vpc_name" {
  description = "Name for VPC"
}
variable "aws_vpc_cidr_block" {
  description = "CIDR Block for VPC"
}

variable "aws_cidr_subnets_private" {
  description = "CIDR Blocks for private subnets in Availability Zones"
  type        = list(string)
}

variable "aws_cidr_subnets_public" {
  description = "CIDR Blocks for public subnets in Availability Zones"
  type        = list(string)
}

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
}
variable "vpc_id" {
  description = "Default tags for all resources"
  type        = string
}
variable "private_subnets" {
  description = "Default tags for all resources"
  type        = list(string)
}
variable "public_subnets" {
  description = "Default tags for all resources"
  type        = list(string)
}
variable "secgroup_id" {
  description = "Default tags for all resources"
  type        = string
}

//AWS EC2 Settings

variable "aws_bastion_size" {
  description = "EC2 Instance Size of Bastion Host"
}

variable "aws_bastion_num" {
  description = "Number of Bastion Nodes"
}

variable "AWS_SSH_KEY_NAME" {
  description = "Name of the SSH keypair to use in AWS."
}
