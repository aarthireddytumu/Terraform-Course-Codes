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
        default = "vpc-0291896b93cdffc32"
        staging = "vpc-0291896b93cdffc32"
        production = "vpc-0291896b93cdffc32"
    }

    vpcid = "${lookup(local.vpcid_env, local.env)}"

    publicsubnetid1_env = {
        default = "subnet-05c37647643d22381"
        staging = "subnet-05c37647643d22381"
        production = "subnet-05c37647643d22381"
    }

    publicsubnetid1 = "${lookup(local.publicsubnetid1_env, local.env)}"

    publicsubnetid2_env = {
        default = "subnet-06ced57ff3a4277ca"
        staging = "subnet-06ced57ff3a4277ca"
        production = "subnet-06ced57ff3a4277ca"
    }

    publicsubnetid2 = "${lookup(local.publicsubnetid2_env, local.env)}"

    privatesubnetid_env = {
        default = "subnet-055deeafab10a9f7d"
        staging = "subnet-055deeafab10a9f7d"
        production = "subnet-055deeafab10a9f7d"
    }

    privatesubnetid = "${lookup(local.privatesubnetid_env, local.env)}"

    amiid_env = {
        default = "ami-0b0ea68c435eb488d"
        staging = "ami-0b0ea68c435eb488d"
        production = "ami-0b0ea68c435eb488d"
    }

    amiid = "${lookup(local.amiid_env, local.env)}"

    instancetype_env = {
        default = "t2.micro"
        staging = "t2.micro"
        production = "t2.medium"
    }

    instancetype = "${lookup(local.instancetype_env, local.env)}"

    keypair_env = {
        default = "test"
        staging = "test"
        production = "test"
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