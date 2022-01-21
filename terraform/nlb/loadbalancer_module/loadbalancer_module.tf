
#variable "privatesg_id" {}

module "shared_vars" {
    source = "../shared_vars"
}

resource "aws_lb" "sampleapp_nlb" {
  name               = "sampleappnlb${module.shared_vars.envsuffix}"
  internal           = false
  load_balancer_type = "network"
  subnets            = ["${module.shared_vars.pubsubnet1}","${module.shared_vars.pubsubnet2}"]

  enable_cross_zone_load_balancing = true
  enable_deletion_protection = true

  tags = {
    Environment = "${module.shared_vars.envsuffix}"

  }
}

resource "aws_lb_target_group" "sampleapp_http_tg" {
  name     = "sampleapp-http-lb-tg-${module.shared_vars.envsuffix}"
  port     = "443"
  protocol = "TLS"
  vpc_id   = "${module.shared_vars.vpcid}"

  health_check {
    protocol = "TCP"
  }
}

output "tg_arn" {
  value = "${aws_lb_target_group.sampleapp_http_tg.arn}"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.sampleapp_nlb.arn}"
  port              = "443"
  protocol          = "TLS"
  #certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
  #alpn_policy       = "HTTP2Preferred"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.sampleapp_http_tg.arn}"
  }
}