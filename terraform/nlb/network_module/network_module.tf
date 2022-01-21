
module "shared_vars" {
    source = "../shared_vars"
    
}

resource "aws_security_group" "publicsg" {
  name        = "publicsg_${module.shared_vars.envsuffix}"
  description = "public sg for load balancers ELB in ${module.shared_vars.envsuffix}"
  vpc_id      = "${module.shared_vars.vpcid}"

  ingress {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
  egress {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      #ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "awssgpub"
  }
}

output "publicsg_id"{
  value = "${aws_security_group.publicsg.id}"
}

resource "aws_security_group" "privatesg" {
  name        = "privatesg_${module.shared_vars.envsuffix}"
  description = "private sg for ec2"
  vpc_id      = "${module.shared_vars.vpcid}"

  ingress {
      description      = "TLS from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      security_groups = ["${aws_security_group.publicsg.id}"]
      #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
  egress {
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      security_groups = ["${aws_security_group.publicsg.id}"]
      #ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
    Name = "awssgprv"
  }
}
output "privatesg_id"{
  value = "${aws_security_group.privatesg.id}"
}
