#To create a new workspace called stage - terraform workspace new stage
#To create another workspace called prod - terraform workspace new prod
#To list the workspace - terraform workspace list
#To swith btwn workspaces - terraform workspace select stage/prod

provider "aws" {
  region     = "us-east-1"
  shared_credentials_file = "C:/Users/aarthi.reddy.tumu/terraform/ec2module/creds"
  profile = "cloud_user"
}

module "sg_module" {
  #sg_name = "sg_ec2_${local.env}"
  source = "./sg_module"
}

module "ec2_module1" {
  sg_id = "${module.sg_module.sg_id_output}"
  ec2key_name = "firstkey"
  #ec2_name = "EC2 Instance_${local.env}"
  source = "./ec2_module"
}

# #localvariables
# locals {
#   env = "${terraform.workspace}"

#   #shared local env variables
#   amiid_env = {
#     default = "amiid_default"
#     stage1 = "amiid_stage"
#     prod = "amiid_prod"
#   }
#   amiid = "${lookup(local.amiid_env, local.env)}"
# }

# output "envspecificoutput_variable" {
#   value = "${local.amiid}"
# }