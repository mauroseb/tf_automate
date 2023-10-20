output "bastion_ip" {
  value       = <<EOF

[+] Logging to the bastion host (CentOS):
ssh centos@${module.bastion.bastion-ip}
EOF
  description = "Bastion access"
}

output "automate_ip" {
  value       = module.automate-ha.a2ha-bastion-ip
  description = "Automate HA bastion IP addresses."
}


output "script" {
  value       = <<EOF

[+] Set up sshuttle
sshuttle -NHr centos@${module.bastion.bastion-ip} 10.1.0.0/16 --dns

* If the private key is not in the default location add: --ssh-cmd 'ssh -i ${var.priv_key_file}''
EOF
  description = "Post deployment script."
}
