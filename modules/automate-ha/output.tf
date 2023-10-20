output "a2ha-bastion-ip" {
  value       = aws_instance.a2ha-bastion.private_ip
  description = "Automate HA Bastion IP address"
}