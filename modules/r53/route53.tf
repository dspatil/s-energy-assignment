resource "aws_route53_zone" "private" {
  name               = "example.com"
  vpc {
    vpc_id = aws_vpc.main.id
    # Add more VPC configurations as needed
  }
  comment            = "Private hosted zone for internal DNS resolution"
}
