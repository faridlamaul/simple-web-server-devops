# Output the public IP address of the EC2 instance

output "ec2_instance_1_public_ip" {
  value = aws_instance.ec2_instance_1.public_ip
}

output "ec2_instance_2_public_ip" {
  value = aws_instance.ec2_instance_2.public_ip
}

output "postgres_instance_address" {
  value = aws_db_instance.db_instance.address
}
