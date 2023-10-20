resource "aws_route53_zone" "a2zone" {
  name       = "${var.env_name}.local."
  depends_on = [aws_vpc.testenv-vpc]
  #private_zone = true
  vpc {
    vpc_id = aws_vpc.testenv-vpc.id
  }
  tags = {
    Owner     = var.owner_tag
    Name      = "${var.env_name}-zone"
    X-Contact = "${var.contact_tag}"
    X-Dept    = "${var.department_tag}"
  }
}

resource "aws_route53_record" "automate" {
  zone_id = aws_route53_zone.a2zone.zone_id
  name    = "automate.${aws_route53_zone.a2zone.name}"
  type    = "A"
  ttl     = "300"
  records = ["10.1.1.100"]

}

resource "aws_route53_record" "infra" {
  zone_id = aws_route53_zone.a2zone.zone_id
  name    = "infra.${aws_route53_zone.a2zone.name}"
  type    = "A"
  ttl     = "300"
  records = ["10.1.1.101"]
}

resource "aws_route53_record" "compliance" {
  zone_id = aws_route53_zone.a2zone.zone_id
  name    = "compliance.${aws_route53_zone.a2zone.name}"
  type    = "A"
  ttl     = "300"
  records = ["10.1.1.100"]
}