resource "aws_security_group" "public_lb_sg" {
  name        = "public_lb_sg"
  description = "Security group for public lb"
  vpc_id      = module.vpc.vpc_id


  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "private_ec2_sg" {
  name        = "private_ec2_sg"
  description = "Security group for private ec2 instance resources"
  vpc_id      = module.vpc.vpc_id


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    source_security_group_id = aws_security_group.public_lb_sg.id
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.company_network_cidr
  }

}
