resource "aws_vpc_endpoint" "s3" {
    vpc_id = aws_vpc.testenv-vpc.id
    service_name = "com.amazonaws.${var.aws_region}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "vpce-rta" {
  for_each        = toset(data.aws_availability_zones.azs.names)
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.testenv-private-rt[each.value].id
}