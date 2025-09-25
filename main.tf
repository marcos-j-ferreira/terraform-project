# block_type "label" {
#   argument = value
#   # Nested blocks or more arguments
# }

# block_type: Defines the type (e.g., resource, provider, variable).
# label: A unique identifier (e.g., aws_instance "example").
# arguments: Key-value pairs configuring the block.

# This block defines the Terraform configuration for global infrastructure settings.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Provider block configures the cloud provider.
# This sets the AWS region where your application will be deployed.
provider "aws" {
  region = var.region
}

# variable: Defines input variables to make configurations flexible.
variable "region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

# variable: Defines instance type for EC2.
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# locals: Define local variables for reusable values within the configuration.
# Simplifies complex expressions and avoids duplication.
locals {
  common_tags = {
    Project = "TerraformLearning"
    Env     = "test"
  }
}

## SG security group; removed, because I don't permission for alter;

# Resource block: Responsible for defining infrastructure components.
# For example: EC2 instance, security group.
# Format: resource "type" "name" { ... }

resource "aws_instance" "testEC2" {
  ami                    = "ami-0360c520857e3138f"
  instance_type          = var.instance_type

  # Reference the correct security group
  # vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = merge(local.common_tags, {
    Name = "TerraformTestServer"
  })
}

# Output: Returns values after `terraform apply`
# Useful to display or pass information to other tools/modules.

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.testEC2.public_ip
}


# Alternative output (commented)
# output "instance_ip" {
#   value = aws_instance.testEC2.public_ip
# }
