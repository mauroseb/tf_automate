variable "aws_region" {
  default     = "eu-central-1"
  description = "Environment region"
  type        = string
}

variable "env_name" {
  default     = "a2"
  description = "Environment name"
  type        = string
}

variable "vpc_ID" {
  description = "VPC ID"
  default     = "mauro-vpc"
  type        = string
}

variable "subnet_ID" {
  description = "Subnet ID"
  default     = ""
  type        = string
}

variable "igw_ID" {
  description = "Internet GW ID"
  default     = ""
  type        = string
}

variable "ubuntu_ami" {
  description = "AMI to use for the ubuntu linux client instance"
  default     = "" # eu-central-1
  type        = string
}

variable "centos_ami" {
  description = "AMI to use for the centos linux client instance"
  default     = "" # eu-central-1
  type        = string
}

variable "win_ami" {
  description = "AMI to use for the win client instance"
  default     = "" # eu-central-1
  type        = string
}

variable "azs" {
  description = "Availavility Zones"
  type        = string
}

variable "owner_tag" {
  default     = "mauro"
  description = "Owner name to tag resources"
  type        = string
}

variable "contact_tag" {
  default     = "mauro@example.com"
  description = "Contact email to tag resources"
  type        = string
}

variable "department_tag" {
  default     = "Success"
  description = "Cluster owner name to tag resources"
  type        = string
}

variable "sleep_tag" {
  default     = "off"
  description = "Override auto-shutdown custodian policy"
  type        = string
}

variable "keypair_name" {
  default     = ""
  description = "Keypair name to use for the client host"
  type        = string
}

variable "priv_key_file" {
  default     = ""
  description = "Private key file corresponding to keypair_name"
  type        = string
}

variable "a2-version" {
  default     = "latest"
  description = "Version for Automate server"
  type        = string
}

variable "win-client-nr" {
  default     = 0
  description = "How many windows client machines to craete."
  type        = number
}

variable "centos-client-nr" {
  default     = 1
  description = "How many centos client machines to craete."
  type        = number
}

variable "ubuntu-client-nr" {
  default     = 0
  description = "How many ubuntu client machines to craete."
  type        = number
}
