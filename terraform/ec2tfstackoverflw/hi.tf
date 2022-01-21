#try tmrw

resource "aws_vpc" "main" {
    cidr_block       = "${var.main_vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_support = true
    enable_dns_hostnames = true

     tags = {
         Name = "main"
            }
        }


 resource "aws_subnet" "subnet1" {
   vpc_id     = "${aws_vpc.main.id}"
   cidr_block = "10.0.1.0/24"
   availability_zone = "${var.availability_zone1}"


  tags  =  {
    Name = "app-subnet-1"
    }
 }
 resource "aws_subnet" "subnet2" {
   vpc_id     = "${aws_vpc.main.id}"
   cidr_block = "10.0.2.0/24"
   availability_zone = "${var.availability_zone2}"


     tags  =  {
      Name = "app-subnet-2"
     }
   }
  resource "aws_subnet" "subnet3" {
   vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.3.0/24"
    availability_zone = "${var.availability_zone1}"


   tags  =  {
     Name = "elb-subnet-1"
 }
}
resource "aws_subnet" "subnet4" {
 vpc_id     = "${aws_vpc.main.id}"
 cidr_block = "10.0.4.0/24"
 availability_zone = "${var.availability_zone2}"


 tags  =  {
  Name = "elb-subnet-2"
  }
 }
    resource "aws_subnet" "subnet5-database" {
    vpc_id     = "${aws_vpc.main.id}"
    cidr_block = "10.0.5.0/24"
     availability_zone = "${var.availability_zone1}"


  tags  =  {
    Name = "db-subnet-1"
 }
}
 resource "aws_subnet" "subnet6-database" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.6.0/24"
  availability_zone = "${var.availability_zone2}"


  tags  =  {
  Name = "db-subnet-2"
  }
 }

 resource "aws_internet_gateway" "main-igw" {
   vpc_id = "${aws_vpc.main.id}"

  tags = {
   Name = "main-igw"
   }
   }


resource "aws_eip" "nat" {
}

resource "aws_nat_gateway" "main-natgw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.subnet4.id}"

  tags = {
    Name = "main-nat"
    }
}

resource "aws_route_table" "main-public-rt" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-igw.id}"
  }

  tags = {
    Name = "main-public-rt"
  }
}

resource "aws_route_table" "main-private-rt" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.main-natgw.id}"
  }
  tags  = {
    Name = "main-private-rt"
  }
}

resource "aws_route_table_association" "public-assoc-1" {
  subnet_id      = "${aws_subnet.subnet3.id}"
  route_table_id = "${aws_route_table.main-public-rt.id}"
}
resource "aws_route_table_association" "public-assoc-2" {
  subnet_id      = "${aws_subnet.subnet4.id}"
  route_table_id = "${aws_route_table.main-public-rt.id}"
}
resource "aws_route_table_association" "private-assoc-1" {
  subnet_id      = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.main-private-rt.id}"
}
resource "aws_route_table_association" "private-assoc-2" {
  subnet_id      = "${aws_subnet.subnet2.id}"
  route_table_id = "${aws_route_table.main-private-rt.id}"
}
resource "aws_route_table_association" "private-assoc-3" {
  subnet_id      = "${aws_subnet.subnet5-database.id}"
  route_table_id = "${aws_route_table.main-private-rt.id}"
}
resource "aws_route_table_association" "private-assoc-4" {
  subnet_id      = "${aws_subnet.subnet6-database.id}"
  route_table_id = "${aws_route_table.main-private-rt.id}"
}


    ########## Create bastion host ######

##resource "aws_default_vpc" "default" {}

resource "aws_instance" "bastion" {

  ami                         = "ami-0fdc6293d3e87a86e"
  key_name                    = "${aws_key_pair.bastion_key.key_name}"
  instance_type               = "t2.micro"
 # security_groups             = ["${aws_security_group.bastion-sg.name}"]
  vpc_security_group_ids      = ["${aws_security_group.bastion-sg.id}"]
  associate_public_ip_address = true
  
  subnet_id = aws_subnet.subnet1.id
  
}

resource "aws_security_group" "bastion-sg" {
  name   = "bastion-security-group"
##  vpc_id = "${aws_default_vpc.default.id}"
   vpc_id = "${aws_vpc.main.id}"

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0 
    to_port     = 0 
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "bastion_key" {
   key_name   = "your_key_name"
   public_key = "ssh-rsa AAA"
}