data "aws_key_pair" "a2ha-keypair" {
  key_name           = var.keypair_name
  include_public_key = true
}

data "aws_vpc" "a2ha-vpc" {
  id = var.vpc_ID
}