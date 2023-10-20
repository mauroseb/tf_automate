variable "aws_region" {
  default     = "eu-central-1"
  description = "Deployment region"
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

variable "ami" {
  description = "AMI to use for the Automate instance"
  default     = "ami-0b2a401a8b3f4edd3" # eu-central-1
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

variable "keypair_name" {
  default     = ""
  description = "Keypair name to use for the client host"
  type        = string
}

variable "priv_key_file" {
  default     = ""
  description = "Keypair's private key file corresponding to keypair_name"
  type        = string
}

variable "infra-version" {
  default     = "latest"
  description = "Infra version to deploy"
  type        = string
}

variable "sleep_tag" {
  default     = "off"
  description = "Override auto-shutdown custodian policy"
  type        = string
}