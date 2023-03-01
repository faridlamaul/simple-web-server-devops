# Create s3 bucket for terraform state
resource "aws_s3_bucket" "terraform-state" {
  bucket        = "terraform-state-devops-backend"
  force_destroy = true
}

# Create s3 bucket acl for terraform state
resource "aws_s3_bucket_acl" "terraform-state-acl" {
  bucket = aws_s3_bucket.terraform-state.id
  acl    = "private"
}

# Create s3 bucket versioning for terraform state
resource "aws_s3_bucket_versioning" "terraform-state-versioning" {
  bucket = aws_s3_bucket.terraform-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Create dynamodb table for terraform state
resource "aws_dynamodb_table" "terraform-state-lock" {
  name         = "terraform-state-lock-devops-backend"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# Create EC2 Instance 1
resource "aws_instance" "ec2_instance_1" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.sg_instances.name]
  tags = {
    Name = "ec2_instance_1"
  }
}

# Create EC2 Instance 2
resource "aws_instance" "ec2_instance_2" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.sg_instances.name]
  tags = {
    Name = "ec2_instance_2"
  }
}

# Create Load Balancer
resource "aws_lb" "load_balancer" {
  name               = "web-app-lb"
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default_subnets.ids
  security_groups    = [aws_security_group.alb.id]

}

# Setup Load Balancer for EC2 Instances 1 and 2
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port = 80
  protocol = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

# Create Target Group for EC2 Instances 1 and 2
resource "aws_lb_target_group" "instances" {
  name     = "ec2-instances-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default_vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Create Target Group Attachment for EC2 Instances 1
resource "aws_lb_target_group_attachment" "instance_1" {
  target_group_arn = aws_lb_target_group.instances.arn
  target_id        = aws_instance.ec2_instance_1.id
  port             = 3000
}

# Create Target Group Attachment for EC2 Instances 2
resource "aws_lb_target_group_attachment" "instance_2" {
  target_group_arn = aws_lb_target_group.instances.arn
  target_id        = aws_instance.ec2_instance_2.id
  port             = 3000
}

# Create Listener Rule for EC2 Instances 1 and 2
resource "aws_lb_listener_rule" "instances" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.instances.arn
  }
}

# Create Database Instance
resource "aws_db_instance" "db_instance" {
  allocated_storage          = 20
  auto_minor_version_upgrade = true
  storage_type               = "standard"
  engine                     = "postgres"
  engine_version             = "12"
  instance_class             = "db.t2.micro"
  db_name                    = var.db_name
  username                   = var.db_user
  password                   = var.db_pass
  skip_final_snapshot        = true
}
