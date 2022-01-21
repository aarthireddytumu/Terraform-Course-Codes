provider "aws" {
  region     = "us-west-2"
  shared_credentials_file = "C:/Users/aarthi.reddy.tumu/terraform/firsttf/creds/cloud_user"
  profile = "cloud_user"
}

#Strings

variable "name" {
  type = string
  default = "aarthireddy"
}
variable "multilinestring" {
  type = string
  default = <<EOH
  this is a multiline
  statement
  newline
  EOH
}
output "myName" {
  value = "${var.name}"
}
output "multilines" {
  value = "${var.multilinestring}"
}


#maps
variable "mapexample" {
  type = map(string)
  default = {
    "useast" = "ami1"
    "eueast" = "ami2"
  }
}
output "mapfulloutput" {
  value = "${var.mapexample}"
}
output "mapoutput" {
  value = "${var.mapexample["useast"]}"
}


#Arrays / Lists

variable "mysecuritylist" {
  type = list
  default = ["sg1","sg2","sg3"]
}
output "sgoutputfull" {
  value = "${var.mysecuritylist}"
}
output "sgoutputindex" {
  value = "${var.mysecuritylist[0]}"
}


#Booleans

variable "testbool" {
  type = bool
  default = false
}
output "booloutput" {
  value = "${var.testbool}"
}

#input & output
variable "myInput" {
  type = string
}
output "myOutput" {
  sensitive = true  #if sensitive is true , it masks the output
  value = "${var.myInput}"
}