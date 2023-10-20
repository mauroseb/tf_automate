data "aws_key_pair" "bastion-keypair" {
  key_name           = var.keypair_name
  include_public_key = true
}