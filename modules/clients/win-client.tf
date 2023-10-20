resource "aws_instance" "win-client" {
  count                  = var.win-client-nr
  ami                    = var.win_ami
  instance_type          = "t3.large"
  key_name               = data.aws_key_pair.client-keypair.key_name
  subnet_id              = var.subnet_ID
  vpc_security_group_ids = [aws_security_group.win-client-sg.id]
  user_data              = file("${path.module}/files/win_user_data.ps1")
  get_password_data      = true
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-win-client_${count.index}"
    X-Contact   = var.contact_tag
    X-Dept      = var.department_tag
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
}