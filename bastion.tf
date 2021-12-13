terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

/*
* Create Bastion Instances in AWS
*
*/

resource "aws_instance" "bastion-server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.aws_bastion_size
  count                       = var.aws_bastion_num
  associate_public_ip_address = true
  # availability_zone           = element(slice(data.aws_availability_zones.available.names, 0, length(var.aws_cidr_subnets_public) <= length(data.aws_availability_zones.available.names) ? length(var.aws_cidr_subnets_public) : length(data.aws_availability_zones.available.names)), count.index)
  subnet_id                   = element(var.public_subnets, count.index)
  # depends_on                  = [module.vote_service_sg]
  vpc_security_group_ids      = [var.secgroup_id]

  key_name = var.AWS_SSH_KEY_NAME
  # name                        = "Bastion"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
  
  # tags = merge(var.default_tags, tomap({
  #   Name    = "${var.aws_cluster_name}-bastion-${count.index}"
  #   Cluster = var.aws_cluster_name
  #   Role    = "bastion-${var.aws_cluster_name}-${count.index}"
  # }))

  user_data = <<EOF
#! /bin/bash
sudo apt-get -y update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt-get -y update
sudo apt-get -y install docker-ce
EOF
  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo apt-get update",
  #     "sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release",
  #     "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
  #     "echo 'deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
  #     "sudo apt-get update",
  #     "sudo apt-get install docker-ce docker-ce-cli containerd.io"
  #   ]
  # }
  # connection {
  #  host        = coalesce(self.public_ip, self.private_ip)
  #  # COALESCE function returns the first non-NULL value from a series of expressions
  #  agent       = true
  #  type        = "ssh"
  #  user        = "ubuntu"
  #  private_key = var.AWS_SSH_KEY_NAME
  # }
}



