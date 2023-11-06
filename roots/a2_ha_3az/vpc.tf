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
  for_each                = toset(data.aws_availability_zones.azs.names)
  depends_on              = [aws_vpc.testenv-vpc]
  vpc_id                  = aws_vpc.testenv-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, index(data.aws_availability_zones.azs.names, each.value) + 1)
  map_public_ip_on_launch = "false"
  availability_zone       = each.value
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-subnet-priv-${each.key}"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_subnet" "testenv-subnet-pub" {
  for_each                = toset(data.aws_availability_zones.azs.names)
  depends_on              = [aws_vpc.testenv-vpc]
  vpc_id                  = aws_vpc.testenv-vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, index(data.aws_availability_zones.azs.names, each.value) + 11)
  map_public_ip_on_launch = "false"
  availability_zone       = each.value
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-subnet-pub-${each.key}"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_internet_gateway" "testenv-igw" {
  vpc_id     = aws_vpc.testenv-vpc.id
  depends_on = [aws_vpc.testenv-vpc]
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-igw"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_route_table" "testenv-public-rt" {
  for_each   = toset(data.aws_availability_zones.azs.names)
  vpc_id     = aws_vpc.testenv-vpc.id
  depends_on = [aws_vpc.testenv-vpc]
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.testenv-igw.id
  }
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-public-rt-${each.value}"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_route_table_association" "testenv-public-rta" {
  for_each       = toset(data.aws_availability_zones.azs.names)
  depends_on     = [aws_vpc.testenv-vpc]
  subnet_id      = aws_subnet.testenv-subnet-pub[each.value].id
  route_table_id = aws_route_table.testenv-public-rt[each.value].id
}


resource "aws_eip" "testenv-eip" {
  for_each   = toset(data.aws_availability_zones.azs.names)
  vpc        = true
  depends_on = [aws_internet_gateway.testenv-igw]
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-natgw-eip-${each.value}"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_nat_gateway" "testenv-natgw" {
  for_each      = toset(data.aws_availability_zones.azs.names)
  allocation_id = aws_eip.testenv-eip[each.value].id
  subnet_id     = aws_subnet.testenv-subnet-pub[each.value].id
  depends_on    = [aws_eip.testenv-eip]

  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-natgw-${each.value}"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }

}

resource "aws_route_table" "testenv-private-rt" {
  for_each = toset(data.aws_availability_zones.azs.names)
  vpc_id   = aws_vpc.testenv-vpc.id
  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.testenv-natgw[each.value].id
  }
  tags = {
    Owner       = var.owner_tag
    Name        = "${var.env_name}-private-rt-${each.value}"
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_route_table_association" "testenv-private-rta" {

  for_each       = toset(data.aws_availability_zones.azs.names)
  subnet_id      = aws_subnet.testenv-subnet-priv[each.value].id
  route_table_id = aws_route_table.testenv-private-rt[each.value].id

}