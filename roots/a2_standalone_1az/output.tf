output "bastion_ip" {
  value       = <<EOF

[+] Logging to the bastion host (CentOS):
ssh centos@${module.bastion.bastion-ip}
EOF
  description = "Bastion access"
}

output "automate_ip" {
  value       = module.automate.automate-ip
  description = "Automate IP addresses."
}

output "infra_ip" {
  value       = module.infra.infra-ip
  description = "Infra Server IP addresses."
}

output "client_ips" {
  value       = module.clients.client-ips
  description = "Clients' IP addresses."
}
#output "win_clients_password" {
#  value = [
#    for i in module.clients.aws_instance.win-client: rsadecrypt(i.password_data, file("mauro.pem"))
#  ]
#  description = "Windows clients' passwords in order."
#}

output "script" {
  value       = <<EOF

[+] Set up sshuttle
sshuttle -NHr centos@${module.bastion.bastion-ip} 10.1.0.0/16 --dns

* If the private key is not in the default location add: --ssh-cmd 'ssh -i ~/path/to/file/nykey.pem'
EOF
  description = "Post deployment script."
}
