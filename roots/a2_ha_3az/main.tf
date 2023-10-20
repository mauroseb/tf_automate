data "aws_caller_identity" "current" {}

data "aws_availability_zones" "azs" {
  state = "available"
  filter {
    name   = "region-name"
    values = [var.aws_region]
  }
}

data "aws_ami" "win_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["801119661308"]
}


module "bastion" {
  source         = "../../modules/bastion"
  depends_on     = [aws_vpc.testenv-vpc, aws_nat_gateway.testenv-natgw]
  aws_region     = var.aws_region
  ami            = var.centos_ami[var.aws_region]
  env_name       = var.env_name
  owner_tag      = var.owner_tag
  contact_tag    = var.contact_tag
  department_tag = var.department_tag
  vpc_ID         = aws_vpc.testenv-vpc.id
  igw_ID         = aws_internet_gateway.testenv-igw.id
  azs            = data.aws_availability_zones.azs.names[0]
  keypair_name   = var.keypair_name
  priv_key_file  = var.priv_key_file
}

module "automate-ha" {
  source         = "../../modules/automate-ha"
  depends_on     = [aws_vpc.testenv-vpc, aws_nat_gateway.testenv-natgw]
  aws_region     = var.aws_region
  ami            = var.centos_ami[var.aws_region]
  env_name       = var.env_name
  owner_tag      = var.owner_tag
  contact_tag    = var.contact_tag
  department_tag = var.department_tag
  vpc_ID         = aws_vpc.testenv-vpc.id
  igw_ID         = aws_internet_gateway.testenv-igw.id
  azs            = data.aws_availability_zones.azs.names[0]
  subnet_ID      = values(aws_subnet.testenv-subnet-priv)[0].id
  keypair_name   = var.keypair_name
  a2ha_version   = var.a2-version
  a2ha_license   = var.a2-license
  iprofile_a2ha  = false
}

module "clients" {
  source           = "../../modules/clients"
  depends_on       = [aws_vpc.testenv-vpc, module.bastion, aws_nat_gateway.testenv-natgw]
  aws_region       = var.aws_region
  ubuntu_ami       = var.ubuntu_ami[var.aws_region]
  centos_ami       = var.centos_ami[var.aws_region]
  win_ami          = data.aws_ami.win_ami.id
  ubuntu-client-nr = 0
  win-client-nr    = 0
  centos-client-nr = 1
  env_name         = var.env_name
  owner_tag        = var.owner_tag
  contact_tag      = var.contact_tag
  department_tag   = var.department_tag
  vpc_ID           = aws_vpc.testenv-vpc.id
  subnet_ID        = aws_subnet.testenv-subnet-priv["eu-central-1a"].id
  igw_ID           = aws_internet_gateway.testenv-igw.id
  azs              = data.aws_availability_zones.azs.names[0]
  keypair_name     = var.keypair_name
  priv_key_file    = var.priv_key_file
}

# locals {
#  centos-ips = var.centos-client-nr != 0 ? join(" ", module.clients.centos-ips) : ""
#  win-ips    = var.win-client-nr != 0 ? join(" ", module.clients.win-ips) : ""
#  ubuntu-ips = var.ubuntu-client-nr != 0 ? join(" ", module.clients.ubuntu-ips) : ""
#  rhel-ips   = var.rhel-client-nr != 0 ? join(" ", module.clients.rhel-ips) : ""
# }

# resource "null_resource" "bastion_postup" {
#  depends_on = [module.bastion, module.clients, module.automate]

#  provisioner "remote-exec" {
#    connection {
#      user        = "centos"
#      type        = "ssh"
#      private_key = file(var.priv_key_file)
#      host        = module.bastion.bastion-ip
#      timeout     = 1200
#    }
#    inline = [
#      "chmod 0400 /home/centos/.ssh/id_rsa_knife",
#      "sleep 300",
#      "while ! ssh ${module.automate.automate-ip} ls userdata-complete.txt ; do sleep 1 ; done 2>/dev/null",
#      "scp ${module.automate.automate-ip}:~/*.pem ~/.chef/",
#      "scp ${module.automate.automate-ip}:~/*.txt ~/.chef/",
#      "scp ${module.automate.automate-ip}:~/automate-credentials.toml .",
#      "while ! ssh ${module.infra.infra-ip} ls userdata-complete.txt ; do sleep 1 ; done 2>/dev/null",
#      "scp ${module.infra.infra-ip}:~/infra-admin.key .",
#      "scp ${module.infra.infra-ip}:~/infra-testorg-validator.pem .",
#      "knife ssl fetch"
#    ]
#  }
# }
