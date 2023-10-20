data "aws_vpc" "client-vpc" {
  id = var.vpc_ID
}

data "aws_key_pair" "client-keypair" {
  key_name           = var.keypair_name
  include_public_key = true
}
