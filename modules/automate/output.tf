output "automate-ip" {
  value       = aws_instance.automate.private_ip
  description = "Automate IP address"
}