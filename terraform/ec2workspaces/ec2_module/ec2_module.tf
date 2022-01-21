variable "amiid" {
  type = string
  default = "ami-087c17d1fe0178315"
}

module "shared_vars" {
  source = "../shared_vars"
}

#Getting input from another module
variable "sg_id" {}
variable "ec2key_name" {}
#variable "ec2_name" {}

resource "aws_instance" "ec2instancelinux" {
  ami           = "${var.amiid}"
  instance_type = "t2.micro"
  key_name = "${var.ec2key_name}"
  vpc_security_group_ids = ["${var.sg_id}"]
  #security_groups = ["${var.sg_id}"]

  tags = {
    Name = "Ec2 Instance_${module.shared_vars.envsuffix}"
    OS = "Linux"
  }
}

