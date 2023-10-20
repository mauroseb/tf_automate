data "aws_key_pair" "a2-keypair" {
  key_name           = var.keypair_name
  include_public_key = true
}

data "aws_vpc" "a2-vpc" {
  id = var.vpc_ID
}