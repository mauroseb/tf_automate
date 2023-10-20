variable "aws_region" {
  default     = "eu-central-1"
  description = "Rosa cluster region"
}

variable "env_name" {
  default     = "testenv"
  description = "Environment name"
}

variable "vpc_ID" {
  description = "VPC ID"
  default     = "vpc-mauro"
  type        = string
}

variable "igw_ID" {
  description = "Internet GW ID"
  default     = ""
  type        = string
}

variable "ami" {
  description = "AMI to use for the bastion instance"
  default     = "ami-0b2a401a8b3f4edd3" # eu-central-1
  type        = string
}

variable "azs" {
  description = "Availavility Zones"
}

variable "owner_tag" {
  default     = "mauro"
  description = "Owner name to tag resources"
}

variable "contact_tag" {
  default     = "mauro@example.com"
  description = "Contact email to tag resources"
}

variable "department_tag" {
  default     = "Success"
  description = "Cluster owner name to tag resources"
}

variable "keypair_name" {
  default     = ""
  description = "Keypair name to use for the client host"
}
variable "priv_key_file" {
  description = "Private key file that corresponds to keypair_name."
  type        = string
}
variable "sleep_tag" {
  default     = "off"
  description = "Override auto-shutdown custodian policy"
  type        = string
}