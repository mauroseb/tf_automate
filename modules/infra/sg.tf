resource "aws_security_group" "infra-sg" {
  name        = "${var.env_name}-infra-sg"
  description = "Allow Chef Infra ports for inbound traffic"
  vpc_id      = var.vpc_ID
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-infra-sg"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}