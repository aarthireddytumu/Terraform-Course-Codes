provider "aws" {
  region     = "us-east-1"
  shared_credentials_file = "C:/Users/aarthi.reddy.tumu/terraform/s3bucket/creds/cloud_user"
  profile = "cloud_user"
}
# resource "aws_key_pair" "deployer" {
#   key_name   = "deployer-key"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAqm06V8MOls0s8S9foyoWvqEi34dpEtSYy2cxKpknWZTaWC2Kq9tpVklBXg85ac5k+0F463JeaRVV8bUb6evsasRAeVJH5A/7laWpy9HS+QdGL0Zzn+L167fzDAEodGaWgCpJLlGivG+Hg5sUlwNJ9JILX6Pf2oLguVdV6Onhv4x+wvNvVJDMv31/kZdfIcA8o8JylXDrC1o/D5DzveZ0s5XupwzW2EKxfmGUWmO9S/a2mZIpVMsRHxb6jfzUiWXUq0jZ0Qe4GchU5OFuG3OTvWZ0msci7eO0CmavIsT7SBGoTZdhshA1h65QayMhk8fk5m7p3Ygh3pgNCEFp7DSoBw== rsa-key-20210915"
# }

variable "vpcid" {
  type = string
  default = "vpc-06602167400d30ab9"
}

resource "aws_security_group" "firstec2sg" {
  name        = "firstec2sg"
  description = "Sg for ec2 instance"
  vpc_id      = "${var.vpcid}"

  ingress {
      description      = "TLS from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["172.31.0.0/16"]
      #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
  egress {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["172.31.0.0/16"]
      #ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "awssg"
  }
}

variable "amiid" {
  type = string
  default = "ami-087c17d1fe0178315"
}

resource "aws_instance" "ec2instancelinux" {
  ami           = "${var.amiid}"
  instance_type = "t2.micro"
  key_name = "firstkey"
  vpc_security_group_ids = ["${aws_security_group.firstec2sg.id}"]
  #security_groups = ["${aws_security_group.firstec2sg.id}"]

  tags = {
    Name = "linuxinstance"
    OS = "Linux"
  }
}
