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

variable "a2-version" {
  default     = "latest"
  description = "Automate version to deploy"
  type        = string
}

variable "a2-license" {
  description = "Automate license"
  type        = string
}

variable "sleep_tag" {
  default     = "off"
  description = "Override auto-shutdown custodian policy"
  type        = string
}