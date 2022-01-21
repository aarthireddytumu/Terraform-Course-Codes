variable "publicsg_id"{}

variable "privatesg_id" {}

module "shared_vars" {
    source = "../shared_vars"
}

resource "aws_lb" "sampleapp_alb" {
  name               = "sampleappalb${module.shared_vars.envsuffix}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.publicsg_id}"]
  subnets            = ["${module.shared_vars.pubsubnet1}","${module.shared_vars.pubsubnet2}"]

  enable_deletion_protection = true

  tags = {
    Environment = "${module.shared_vars.envsuffix}"
  }
}

resource "aws_lb_target_group" "sampleapp_http_tg" {
  name     = "sampleapp-http-lb-tg-${module.shared_vars.envsuffix}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${module.shared_vars.vpcid}"
}

output "tg_arn" {
  value = "${aws_lb_target_group.sampleapp_http_tg.arn}"
}

resource "aws_lb_listener" "http_listener_80" {
  load_balancer_arn = "${aws_lb.sampleapp_alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.sampleapp_http_tg.arn}"
  }
}