output "bastion-ip" {
  value       = aws_instance.bastion.public_ip
  description = "Bastion IP address"
}
