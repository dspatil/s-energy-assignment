resource "aws_route53_zone" "private" {
  name              = "example.com"
  vpc {
    vpc_id = module.vpc.vpc_id
  }
  comment           = "Private hosted zone for internal DNS resolution"
}

resource "aws_route53_record" "example" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "test.example.com"
  type    = "A"
  ttl     = "300"
  records = module.load_balancer.load_balancer_dns_name  # Replace with the private IP of your instance
}


output "private_zone_id" {
  value = aws_route53_zone.private.zone_id
}
