resource "random_string" "suffix" {
  length           = 4
  special          = false
  upper            = false
}

resource "aws_s3_bucket" "a2ha_bucket" {
    bucket = "${var.env_name}-a2ha-bucket-${random_string.suffix.id}"
    acl    = "private"
    tags = {
        Owner     = var.owner_tag
        Name      = "${var.env_name}-zone"
        X-Contact = "${var.contact_tag}"
        X-Dept    = "${var.department_tag}"
    }
}