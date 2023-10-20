resource "aws_instance" "centos-client" {
  count                  = var.centos-client-nr
  ami                    = var.centos_ami
  instance_type          = "t3.micro"
  key_name               = data.aws_key_pair.client-keypair.key_name
  subnet_id              = var.subnet_ID
  vpc_security_group_ids = [aws_security_group.linux-client-sg.id]
  user_data              = templatefile("${path.module}/templates/centos_user_data.sh.tftpl", { username = "centos", env_name = var.env_name })
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-centos-client_${count.index}"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
}
