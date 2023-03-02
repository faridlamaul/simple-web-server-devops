# Resource Definitions
resource "aws_instance" "webserver" {
  ami             = var.ami
  instance_type   = var.instance_type
  key_name        = var.key_name
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]
  user_data       = <<-EOF
              #!/bin/bash
              sudo apt-get update
              sudo apt install -y ansible
              EOF
  tags = {
    Name = "webserver"
  }
}

resource "aws_db_instance" "postgres" {
  allocated_storage      = 10
  engine                 = "postgres"
  engine_version         = "12"
  instance_class         = "db.t2.micro"
  db_name                = var.db_name
  username               = var.db_user
  password               = var.db_pass
  parameter_group_name   = "default.postgres12"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
}
