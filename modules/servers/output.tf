output "status_instance_ip" {
  value = aws_instance.status.private_ip
}

output "lighting_instance_id" {
  value = aws_instance.lighting.id
}

output "heating_instance_id" {
  value = aws_instance.heating.id
}

output "status_instance_id" {
  value = aws_instance.status.id
}

output "auth_instance_id" {
  value = aws_instance.auth.id
}