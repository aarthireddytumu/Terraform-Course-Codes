variable "vpcid" {
  type = string
  default = "vpc-061e4f1ae2de8b35d"
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

