resource "aws_subnet" "bastion-subnet" {
  vpc_id                  = var.vpc_ID
  cidr_block              = "10.1.10.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.azs
  tags = {
    Owner = var.owner_tag
    Name  = "${var.env_name}-subnet-bastion"
  }
}

resource "aws_route_table" "bastion-rt" {
  vpc_id = var.vpc_ID
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_ID
  }
  tags = {
    Owner = var.owner_tag
    Name  = "${var.env_name}-bastion-rt"
  }
}

resource "aws_route_table_association" "bastion-rta" {
  subnet_id      = aws_subnet.bastion-subnet.id
  route_table_id = aws_route_table.bastion-rt.id
}
