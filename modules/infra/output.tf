output "infra-ip" {
  value       = aws_instance.infra.private_ip
  description = "Infra IP address"
}