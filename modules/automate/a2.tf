resource "aws_instance" "automate" {
  depends_on             = [aws_security_group.a2-sg]
  ami                    = var.ami
  instance_type          = "t3a.large" #m5.xlarge
  private_ip             = "10.1.1.100"
  key_name               = data.aws_key_pair.a2-keypair.key_name
  subnet_id              = var.subnet_ID
  vpc_security_group_ids = [aws_security_group.a2-sg.id]
  user_data              = templatefile("${path.module}/templates/user_data.sh.tftpl", { username = "centos", version = var.a2-version, env_name = var.env_name, a2-license = var.a2-license })
  root_block_device {
    volume_size = 40
  }
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-automate"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  #provisioner "file" {
  #    content     = var.a2-license
  #    destination = "/tmp/license.jwt"
  #    connection {
  #        user        = "centos"
  #        type        = "ssh"
  #        private_key = file(var.priv_key_file)
  #        host        = self.public_ip
  #    }
  #}
}
