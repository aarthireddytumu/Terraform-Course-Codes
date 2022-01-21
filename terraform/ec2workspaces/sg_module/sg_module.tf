variable "vpcid" {
  type = string
  default = "vpc-0425250d80491599c"
}

module "shared_vars" {
  source = "../shared_vars"
}

resource "aws_security_group" "ec2sg" {
  name        = "sg_ec2_${module.shared_vars.envsuffix}"
  description = "ec2 instance"
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

output "sg_id_output" {
  value = "${aws_security_group.ec2sg.id}"
}
