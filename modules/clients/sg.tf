resource "aws_security_group" "linux-client-sg" {
  name        = "${var.env_name}-linux-client-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpc_ID
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-linux-client-sg"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.client-vpc.cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_security_group" "win-client-sg" {
  name        = "${var.env_name}-win-client-sg"
  description = "Allow RDP and WINRM inbound traffic"
  vpc_id      = var.vpc_ID
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-win-client-sg"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
  ingress {
    description = "RDP"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.client-vpc.cidr_block]
  }
  ingress {
    description = "WinRM HTTP"
    from_port   = 5985
    to_port     = 5985
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.client-vpc.cidr_block]
  }
  ingress {
    description = "WinRM HTTPs"
    from_port   = 5986
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.client-vpc.cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}