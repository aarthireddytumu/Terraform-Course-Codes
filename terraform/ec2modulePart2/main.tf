provider "aws" {
  region     = "us-east-1"
  shared_credentials_file = "C:/Users/aarthi.reddy.tumu/terraform/ec2module/creds"
  profile = "cloud_user"
}

module "sg_module" {
  source = "./sg_module"
}

#Launch multiple instances in single go
module "ec2_module1" {
  #Getting output from 1 module and giving input to another module
  sg_id = "${module.sg_module.sg_id_output}"
  ec2key_name = "firstkey"
  #TagName/InstanceName
  ec2_name = "firstlinux"
  #Path of the module
  source = "./ec2_module"
}
module "ec2_module2" {        
  sg_id = "${module.sg_module.sg_id_output}"
  ec2key_name = "firstkey"
  ec2_name = "secondlinux"
  source = "./ec2_module"
}