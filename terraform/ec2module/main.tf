provider "aws" {
  region     = "us-east-1"
  shared_credentials_file = "C:/Users/aarthi.reddy.tumu/terraform/ec2module/creds"
  profile = "cloud_user"
}

module "ec2_module" {
  source = "./ec2_module"
}