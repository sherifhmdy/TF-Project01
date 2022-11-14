resource "aws_subnet" "development-subnet-1" {
    vpc_id = var.vpc_id 
    cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
}

resource "aws_internet_gateway" "development-igw" {
    vpc_id = var.vpc_id 
}

resource "aws_default_route_table" "main-rtb" {
    default_route_table_id = var.default_rtb_id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.development-igw.id
    }
}

resource "aws_default_security_group" "main-sg" {
    vpc_id = var.vpc_id

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp" 
        cidr_blocks = [var.my_ip]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp" 
        cidr_blocks = [var.my_ip]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1" 
        cidr_blocks = ["0.0.0.0/0"]
    }
}