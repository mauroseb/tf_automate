resource "aws_security_group" "a2ha-sg" {
  name        = "${var.env_name}-a2ha-sg"
  description = "Allow all automate ports for inbound traffic"
  vpc_id      = var.vpc_ID
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-a2ha-sg"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "OpenSearch"
    from_port   = 9200
    to_port     = 9400
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "Habitat API"
    from_port   = 9631
    to_port     = 9631
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "Habitat Gossip TCP"
    from_port   = 9638
    to_port     = 9638
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "Habitat Gossip UDP"
    from_port   = 9638
    to_port     = 9638
    protocol    = "udp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "HA Proxy PostgreSQL"
    from_port   = 7432
    to_port     = 7432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "Re-elect PostgreSQL"
    from_port   = 6432
    to_port     = 6432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "HA Proxy PostgreSQL"
    from_port   = 7432
    to_port     = 7432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  ingress {
    description = "Automate Stream"
    from_port   = 4222
    to_port     = 4222
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.a2ha-vpc.cidr_block]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}