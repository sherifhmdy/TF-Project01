output "subnet" {
    value = aws_subnet.development-subnet-1
}

output "sg" {
    value = aws_default_security_group.main-sg
}