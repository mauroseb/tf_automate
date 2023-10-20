data "aws_key_pair" "infra-keypair" {
  key_name           = var.keypair_name
  include_public_key = true
}

data "aws_vpc" "infra-vpc" {
  id = var.vpc_ID
}