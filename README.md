## Penjelesan mengenai Repository ini

### Tools yang digunakan
1. AWS EC2 (Ubuntu 18.04) untuk menjalankan Webserver
2. AWS RDS (Postgres) untuk database
3. AWS CloudWatch untuk monitoring
4. Terraform untuk provisioning AWS resources
5. Ansible untuk provisioning Webserver
6. Docker untuk menjalankan Webserver
7. Docker Compose untuk menjalankan Webserver dan Database

### Cara menjalankan
1. Clone repository ini
2. Masuk ke folder `terraform`
3. Copy file `terraform.tfvars.example` menjadi `terraform.tfvars`
4. Isi `terraform.tfvars` dengan data yang sesuai
3. Jalankan `terraform init`
4. Jalankan `terraform plan`
4. Jalankan `terraform apply`
5. Masuk ke folder `ansible`
6. Jalankan `./deploy.sh`
9. Buka browser dan akses `http://<public_ip_ec2>:3000`