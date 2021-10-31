output "default_vpc_cidr_block" {
    value = aws_default_vpc.default.cidr_block
}

output "default_vpc_id" {
    value = aws_default_vpc.default.id
}

output "SG_name" {
    value = aws_security_group.allow_web.name
}