resource "aws_security_group" "bastion-sg" {
  name        = "${var.env_name}-bastion-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_ID
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-bastion-sg"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}