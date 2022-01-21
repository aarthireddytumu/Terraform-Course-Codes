provider "aws" {
    profile = "cloud_user"
    shared_credentials_file = "C:/Users/aarthi.reddy.tumu/terraform/nlb/creds/cloud_user"
    region = "us-east-1"
}

module "network_module" {
    source = "./network_module"
}

module "loadbalancer_module" {
    source = "./loadbalancer_module"
}

module "autoscaling_module" {
    source = "./autoscaling_module"
    privatesg_id = "${module.network_module.privatesg_id}"
    tg_arn = "${module.loadbalancer_module.tg_arn}"
}