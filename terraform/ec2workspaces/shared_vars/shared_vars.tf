#localvariables
locals {
  env = "${terraform.workspace}"

  #shared local env variables
  envsuffix_env = {
    default = "stage1"
    stage1 = "stage1"
    prod = "prod"
  }
  envsuffix = "${lookup(local.envsuffix_env, local.env)}"
}

output "envsuffix" {
  value = "${local.envsuffix}"
}