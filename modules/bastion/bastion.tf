resource "aws_instance" "bastion" {
  depends_on                  = [aws_security_group.bastion-sg, aws_subnet.bastion-subnet]
  ami                         = var.ami
  associate_public_ip_address = true
  instance_type               = "t3.micro"
  private_ip                  = "10.1.10.10"
  key_name                    = data.aws_key_pair.bastion-keypair.key_name
  subnet_id                   = aws_subnet.bastion-subnet.id
  vpc_security_group_ids      = [aws_security_group.bastion-sg.id]
  user_data                   = templatefile("${path.module}/templates/user_data.sh.tftpl", { username = "centos", env_name = var.env_name })
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-bastion"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
  credit_specification {
    cpu_credits = "unlimited"
  }
  provisioner "file" {
    source      = var.priv_key_file
    destination = "/home/centos/.ssh/id_rsa_knife"
    #file_permission = 0400
    connection {
      user        = "centos"
      type        = "ssh"
      private_key = file(var.priv_key_file)
      host        = self.public_ip
    }
  }
}