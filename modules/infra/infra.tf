resource "aws_instance" "infra" {
  depends_on             = [aws_security_group.infra-sg]
  ami                    = var.ami
  instance_type          = "t3a.large" #m5.xlarge
  private_ip             = "10.1.1.101"
  key_name               = data.aws_key_pair.infra-keypair.key_name
  subnet_id              = var.subnet_ID
  vpc_security_group_ids = [aws_security_group.infra-sg.id]
  user_data              = templatefile("${path.module}/templates/user_data.sh.tftpl", { username = "centos", version = var.infra-version })
  root_block_device {
    volume_size = 40
  }
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-infra"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
}