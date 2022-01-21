module "shared_vars" {
    source = "../shared_vars"
    
}

variable "privatesg_id" {}
#variable "tg_arn" {}


resource "aws_launch_configuration" "sampleapp_lc" {
  name          = "sampleapp_lc_${module.shared_vars.envsuffix}"
  image_id      = "${module.shared_vars.amiid}"
  instance_type = "${module.shared_vars.instancetype}"
  key_name = "${module.shared_vars.keypair}"
  user_data = "${file("C:/Users/aarthi.reddy.tumu/terraform/awsproject/assets/userdata.txt")}"
  security_groups = ["${var.privatesg_id}"]
}

resource "aws_autoscaling_group" "sampleapp_asg" {
  name                 = "sampleapp_asg_${module.shared_vars.envsuffix}"
  max_size             = 2
  min_size             = 1
  desired_capacity = 1
  launch_configuration = aws_launch_configuration.sampleapp_lc.name
  vpc_zone_identifier  = ["${module.shared_vars.prvsubnet}"]
  target_group_arns = "${var.tg_arn}"

  tags = [
      {
        "key"                 = "Name"
        "value"               = "sampleapp_${module.shared_vars.envsuffix}"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Env"
        "value"               = "${module.shared_vars.envsuffix}"
        "propagate_at_launch" = true
      }
    ]
}