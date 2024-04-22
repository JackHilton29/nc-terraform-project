output "public_security_groups" {
    value = [aws_security_group.sg[0].id, aws_security_group.sg[1].id, aws_security_group.sg[2].id, aws_security_group.sg[4].id]
}

output "private_security_groups" {
    value = [aws_security_group.sg[0].id, aws_security_group.sg[1].id, aws_security_group.sg[3].id, aws_security_group.sg[4].id]
}