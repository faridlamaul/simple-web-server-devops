# Create a security group
resource "aws_security_group" "sg_instances" {
  name        = "sg_ec2_instances"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = data.aws_vpc.default_vpc.id
}

resource "aws_security_group_rule" "allow_http_inbound" {
  from_port         = 3000
  protocol          = "tcp"
  security_group_id = aws_security_group.sg_instances.id
  to_port           = 3000
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "alb" {
  name = "alb-security-group"
}

resource "aws_security_group_rule" "allow_alb_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id

  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_alb_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb.id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
