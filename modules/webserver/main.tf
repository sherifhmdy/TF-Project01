data "aws_ami" "aws-linux2" {
    most_recent = true 
    filter {
        name = "name"
        values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2*"]
    }
}

resource "aws_key_pair" "mykey" {
        key_name = "developer_key"
        public_key = file(var.pub_key_location)
}

resource "aws_instance" "development-instance" {
    ami = data.aws_ami.aws-linux2.id
    associate_public_ip_address = true
    instance_type = "t2.micro"
    availability_zone = var.availability_zone
    key_name = "developer_key"
    vpc_security_group_ids =[var.vpc_sg_ids]
    subnet_id = var.subnet_id
    user_data = file("/Users/sheriff/Documents/WorkSpaces/terraform/myproject/entry-data.sh")
}

