provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "development-vpc" {
    cidr_block = var.vpc_cidr_block
}

module "development-subnet" {
    source = "./modules/subnet"
    vpc_id = aws_vpc.development-vpc.id
    subnet_cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
    default_rtb_id = aws_vpc.development-vpc.default_route_table_id
    my_ip = var.my_ip
}

module "ec2-instance" {
    source = "./modules/webserver"
    pub_key_location = var.pub_key_location
    availability_zone = var.availability_zone
    vpc_sg_ids = module.development-subnet.sg.id
    subnet_id = module.development-subnet.subnet.id
}