resource "aws_instance" "a2ha-bastion" {
  depends_on             = [aws_security_group.a2ha-sg]
  ami                    = var.ami
  instance_type          = "t3a.large" #m5.xlarge
  private_ip             = "10.1.1.100"
  key_name               = data.aws_key_pair.a2ha-keypair.key_name
  subnet_id              = var.subnet_ID
  vpc_security_group_ids = [aws_security_group.a2ha-sg.id]
  user_data              = templatefile("${path.module}/templates/user_data.sh.tftpl", { username = "centos", version = var.a2ha_version, env_name = var.env_name, a2ha-license = var.a2ha_license })
  iam_instance_profile   = var.iprofile_a2ha ? flatten(aws_iam_instance_profile.a2ha_bastion_profile)[0] : null
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
