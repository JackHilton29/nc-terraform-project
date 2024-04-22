output "DNS_name" {
    value = aws_lb.public.dns_name
}

output "lighting_target_arn" {
    value = aws_lb_target_group.lighting.arn
}

output "heating_target_arn" {
    value = aws_lb_target_group.heating.arn
}

output "status_target_arn" {
    value = aws_lb_target_group.status.arn
}

output "auth_target_arn" {
    value = aws_lb_target_group.auth.arn
}