resource "aws_security_group" "a2-sg" {
  name        = "${var.env_name}-a2-sg"
  description = "Allow all automate ports for inbound traffic"
  vpc_id      = var.vpc_ID
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-a2-sg"
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
  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "OpenSearch"
    from_port   = 9200
    to_port     = 9400
    protocol    = "tcp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Habitat API"
    from_port   = 9631
    to_port     = 9631
    protocol    = "tcp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Habitat Gossip TCP"
    from_port   = 9638
    to_port     = 9638
    protocol    = "tcp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Habitat Gossip UDP"
    from_port   = 9638
    to_port     = 9638
    protocol    = "udp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "HA Proxy PostgreSQL"
    from_port   = 7432
    to_port     = 7432
    protocol    = "tcp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Re-elect PostgreSQL"
    from_port   = 6432
    to_port     = 6432
    protocol    = "tcp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "HA Proxy PostgreSQL"
    from_port   = 7432
    to_port     = 7432
    protocol    = "tcp"
    #cidr_blocks      = [data.aws_vpc.a2-vpc.cidr_block]
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = [data.aws_vpc.a2-vpc.ipv6_cidr_block]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description = "Automate Stream"
    from_port   = 4222
    to_port     = 4222
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