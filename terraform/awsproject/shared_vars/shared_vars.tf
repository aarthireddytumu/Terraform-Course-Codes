output "vpcid"{
    value = "${local.vpcid}"
}
output "pubsubnet1"{
    value = "${local.publicsubnetid1}"
}
output "pubsubnet2"{
    value = "${local.publicsubnetid2}"
}
output "prvsubnet"{
    value = "${local.privatesubnetid}"
}

output "amiid"{
    value = "${local.amiid}"
}

output "instancetype"{
    value = "${local.instancetype}"
}

output "keypair" {
    value = "${local.keypair}"
}

output "envsuffix"{
    value = "${local.env}"
}

# output "asgdesired"{
#     value = "${local.env}"
# }

# output "asgmin"{
#     value = "${local.env}"
# }

# output "asgmax"{
#     value = "${local.env}"
# }



locals {
    env = "${terraform.workspace}"

    vpcid_env = {
        default = "vpc-0c5b1742fcbd625dd"
        staging = "vpc-0c5b1742fcbd625dd"
        production = "vpc-0c5b1742fcbd625dd"
    }

    vpcid = "${lookup(local.vpcid_env, local.env)}"

    publicsubnetid1_env = {
        default = "subnet-0ee267da8e92cc2b6"
        staging = "subnet-0ee267da8e92cc2b6"
        production = "subnet-0ee267da8e92cc2b6"
    }

    publicsubnetid1 = "${lookup(local.publicsubnetid1_env, local.env)}"

    publicsubnetid2_env = {
        default = "subnet-0b542cbbbebaa2bb4"
        staging = "subnet-0b542cbbbebaa2bb4"
        production = "subnet-0b542cbbbebaa2bb4"
    }

    publicsubnetid2 = "${lookup(local.publicsubnetid2_env, local.env)}"

    privatesubnetid_env = {
        default = "subnet-0c7a9ef1c003a89d0"
        staging = "subnet-0c7a9ef1c003a89d0"
        production = "subnet-0c7a9ef1c003a89d0"
    }

    privatesubnetid = "${lookup(local.privatesubnetid_env, local.env)}"

    amiid_env = {
        default = "ami-087c17d1fe0178315"
        staging = "ami-087c17d1fe0178315"
        production = "ami-087c17d1fe0178315"
    }

    amiid = "${lookup(local.amiid_env, local.env)}"

    instancetype_env = {
        default = "t2.micro"
        staging = "t2.micro"
        production = "t2.medium"
    }

    instancetype = "${lookup(local.instancetype_env, local.env)}"

    keypair_env = {
        default = "firstkey_staging"
        staging = "firstkey_staging"
        production = "firstkey_prod"
    }

    keypair = "${lookup(local.keypair_env, local.env)}"

    # asgdesired_env = {
    #     default = 1
    #     staging = 1
    #     production = 2
    # }

    # asgdesired = "${lookup(local.asgdesired_env, local.env)}"

    # asgmin_env = {
    #     default = 1
    #     staging = 1
    #     production = 2
    # }

    # asgmin = "${lookup(local.asgmin_env, local.env)}"

    # asgmax_env = {
    #     default = 2
    #     staging = 2
    #     production = 4
    # }

    # asgmax = "${lookup(local.asgmax_env, local.env)}"
}