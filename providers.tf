terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# provides a resource to manage the default AWS VPC in the current region.
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}


