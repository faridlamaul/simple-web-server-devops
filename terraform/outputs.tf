# Output the public IP address of the EC2 instance
output "web_server_public_ip" {
  value = aws_instance.webserver.public_ip
}
