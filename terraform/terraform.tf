terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.55.0"
    }
  }
}

# Configure the AWS Provider with the ap-southeast-1 region
provider "aws" {
  region = var.region
}
