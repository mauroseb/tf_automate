output "client-ips" {
  value = flatten([
    aws_instance.centos-client.*.private_ip,
    aws_instance.win-client.*.private_ip,
    #aws_instance.ubuntu-client.*.private_ip
  ])
  description = "All clients' private IP addresses"
}

output "centos-ips" {
  value = flatten([
    aws_instance.centos-client.*.private_ip,
  ])
  description = "All Centos clients' private IP addresses"
}

output "win-ips" {
  value = flatten([
    aws_instance.win-client.*.private_ip,
  ])
  description = "All Windows clients' private IP addresses"
}

output "win-passwords" {
  value       = [for i in aws_instance.win-client : rsadecrypt(i.password_data, file(var.priv_key_file))]
  description = "All Windows clients' passwords"
}

#output "ubuntu-ips" {
#    value = flatten([
#      aws_instance.ubuntu-client.*.private_ip,
#      ])
#    description = "All Ubuntu clients' private IP addresses"
#}

#output "rhel-ips" {
#    value = flatten([
#      aws_instance.rhel-client.*.private_ip,
#      ])
#    description = "All RHEL clients' private IP addresses"
#}