variable "aws_region" {
  default     = "eu-west-3"
  description = "AWS region where to deploy."
  type        = string
}

variable "env_name" {
  default     = "a2-02"
  description = "Environment name"
  type        = string
}

variable "owner_tag" {
  default     = "undefined"
  description = "Owner name to tag resources"
  type        = string
}

variable "contact_tag" {
  default     = "undefined"
  description = "Contact email to tag resources with X-Contact tag"
  type        = string
}

variable "department_tag" {
  default     = "undefined"
  description = "Department name to tag resources with X-Dept tag"
  type        = string
}

variable "sleep_tag" {
  default     = "off"
  description = "Override auto-shutdown custodian policy"
  type        = string
}

variable "vpc_cidr" {
  default     = "10.1.0.0/16"
  description = "Cluster CIDR (VPC segment)"
  type        = string
}

variable "pubkey" {
  default     = ""
  description = "Creates new keypair from pubkey to use in any system that requires it."
  type        = string
}

variable "keypair_name" {
  default     = "mauro"
  description = "Existing keypair to use in any system that requires it."
  type        = string
}

variable "priv_key_file" {
  description = "Private key file that corresponds to keypair_name."
  type        = string
}

variable "a2-version" {
  default     = "latest"
  description = "Automate version."
  type        = string
}

variable "a2-license" {
  default     = "latest"
  description = "Automate license."
  type        = string
}

variable "infra-version" {
  default     = "latest"
  description = "Infra version."
  type        = string
}

variable "centos-client-nr" {
  default     = 0
  description = "Number of Centos clients to create"
  type        = number
}

variable "ubuntu-client-nr" {
  default     = 0
  description = "Number of Ubuntu clients to create"
  type        = number
}

variable "rhel-client-nr" {
  default     = 0
  description = "Number of RHEL clients to create"
  type        = number
}

variable "win-client-nr" {
  default     = 0
  description = "Number of Windows clients to create"
  type        = number
}

# Using RHEL AMIs https://access.redhat.com/solutions/15356
variable "rhel_ami" {
  type = map(any)
  default = {
    af-south-1     = "ami-062c4716a546acec9"
    ap-south-1     = "ami-05c8ca4485f8b138a"
    ap-northeast-1 = "ami-0f903fb156f24adbf"
    ap-northeast-2 = "ami-06c568b08b5a431d5"
    ap-northeast-3 = "ami-044921b7897a7e0da"
    ap-southeast-1 = "ami-0fb1ff50b2338a261"
    ap-southeast-2 = "ami-0808460885ff81045"
    ca-central-1   = "ami-0c3d3a230b9668c02"
    eu-central-1   = "ami-0e7e134863fac4946"
    eu-north-1     = "ami-06a2a41d455060f8b"
    eu-west-1      = "ami-0f0f1c02e5e4d9d9f"
    eu-west-2      = "ami-035c5dc086849b5de"
    eu-west-3      = "ami-0460bf124812bebfa"
    sa-east-1      = "ami-0c1b8b886626f940c"
    us-east-1      = "ami-06640050dc3f556bb"
    us-east-2      = "ami-092b43193629811af"
    us-west-1      = "ami-0186e3fec9b0283ee"
    us-west-2      = "ami-0bb199dd39edd7d71"
  }
  description = "RHEL AMI selector."
}

variable "ubuntu_ami" {
  type = map(any)
  default = {
    af-south-1     = "ami-03fb8922332cce801"
    ap-east-1      = "ami-0e00e6145ab1837b4"
    ap-south-1     = "ami-0eb22e4d8a8d4fde8"
    ap-northeast-1 = "ami-03baa3575a5f30358"
    ap-southeast-1 = "ami-09dac21d1664bc313"
    ca-central-1   = "ami-021ca25871f1697f7"
    cn-north-1     = "ami-0d688c694ae459a67"
    cn-northwest-1 = "ami-0f34360021b18ed7a"
    eu-central-1   = "ami-074543d9faf9c0509"
    eu-north-1     = "ami-0d9ebebc2277c01cb"
    eu-south-1     = "ami-07104405789e5afac"
    eu-west-1      = "ami-0242bc425da698fba"
    me-central-1   = "ami-02ec54bc0a27faa40"
    me-south-1     = "ami-0e0aab5c81dcbb143"
    sa-east-1      = "ami-009dac42914e64b32"
    us-east-1      = "ami-06a1f46caddb5669e"
    us-west-1      = "ami-075138a50b1af6e68"
  }
  description = "Ubuntu AMI selector."
}

variable "centos_ami" {
  type = map(any)
  default = {
    af-south-1     = "ami-02d3032c746029f27"
    ap-east-1      = "ami-0e00e6145ab1837b4"
    ap-south-1     = "ami-04373a79128fecec9"
    eu-central-1   = "ami-008df941b5f59bc6b"
    eu-south-1     = "ami-07104405789e5afac"
    eu-west-1      = "ami-0d23814c7e4d7ad44"
    eu-north-1     = "ami-0d10e7602dcd2f038"
    sa-east-1      = "ami-09a03f67e2bbbc632"
    ap-east-1      = "ami-0641735f85e6b8b76"
    us-west-1      = "ami-00e49bfac4724fe94"
    ap-northeast-1 = "ami-0841660f552d877e3"
    ap-southeast-1 = "ami-0fba6bd05f8d7482b"
    us-east-1      = "ami-03a84a8ee762d09e8"
    ca-central-1   = "ami-0948b7442da9428a3"
    me-south-1     = "ami-0814beedafa8ef779"
  }
  description = "Centos Stream 8 AMI selector."
}