resource "aws_iam_role" "a2ha_bastion_role" {
  count = var.iprofile_a2ha ? 1 : 0
  name  = "${var.env_name}-a2ha_bastion_role"
  path  = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["ec2.amazonaws.com"]
        }
      },
    ]
  })

  tags = {
    Owner       = var.owner_tag
    X-Contact   = "${var.contact_tag}"
    X-Dept      = "${var.department_tag}"
    Create-Date = formatdate("MMM DD, YYYY", timestamp())
  }
}

resource "aws_iam_instance_profile" "a2ha_bastion_profile" {
  count = var.iprofile_a2ha ? 1 : 0
  name  = "${var.env_name}-a2ha_bastion_profile"
  role  = aws_iam_role.a2ha_bastion_role[0].name
}

resource "aws_iam_role_policy" "a2ha_bastion_policy" {
  # AdministratorAccess and s3FullAccess
  count = var.iprofile_a2ha ? 1 : 0
  name  = "a2ha_bastion_policy"
  role  = aws_iam_role.a2ha_bastion_role[0].id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}