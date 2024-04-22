output "DNS_name" {
    value = "${module.load-balancers.DNS_name}"
}

output "private_subnet" {
  value = "${module.autoscaling[0].private_subnet}"
}