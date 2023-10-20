resource "aws_vpc" "testenv-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-vpc"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_subnet" "testenv-subnet-priv" {
  vpc_id                  = aws_vpc.testenv-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 1)
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.azs.names[0]
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-subnet-priv"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_subnet" "testenv-subnet-pub" {
  vpc_id                  = aws_vpc.testenv-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, 2)
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.azs.names[0]
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-subnet-pub"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_internet_gateway" "testenv-igw" {
  vpc_id = aws_vpc.testenv-vpc.id
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-igw"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_route_table" "testenv-public-rt" {
  vpc_id = aws_vpc.testenv-vpc.id
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.testenv-igw.id
  }
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-public-rt"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_route_table_association" "testenv-public-rta" {
  subnet_id      = aws_subnet.testenv-subnet-pub.id
  route_table_id = aws_route_table.testenv-public-rt.id
}


resource "aws_eip" "testenv-eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.testenv-igw]
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-natgw-eip"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_nat_gateway" "testenv-natgw" {
  allocation_id = aws_eip.testenv-eip.id
  subnet_id     = aws_subnet.testenv-subnet-pub.id
  depends_on    = [aws_eip.testenv-eip]

  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-natgw"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }

}

resource "aws_route_table" "testenv-private-rt" {
  vpc_id = aws_vpc.testenv-vpc.id
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.testenv-natgw.id
  }
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-private-rt"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_route_table_association" "testenv-private-rta" {
  subnet_id      = aws_subnet.testenv-subnet-priv.id
  route_table_id = aws_route_table.testenv-private-rt.id
}