#Global Vars
aws_vpc_name = "my-vpc"

#VPC Vars
aws_vpc_cidr_block       = "10.0.0.0/16"
aws_cidr_subnets_private = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
aws_cidr_subnets_public  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]


default_tags = {
  Env     = "test"
  Product = "bastion"
}
aws_bastion_size = "t2.micro"
aws_bastion_num  = 1
# AWS_SSH_KEY_NAME= "test-01"

