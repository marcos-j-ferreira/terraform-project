provider "aws" {
  region = "us-east-1"
}

module "ec2_instance_1" {
  source        = "./modules/ec2_instance"
  ami_id        = var.ami_id
  instance_type = "t3.micro"
  instance_name = "ec2-instance-1"
}

module "ec2_instance_2" {
  source        = "./modules/ec2_instance"
  ami_id        = var.ami_id
  instance_type = "t3.micro"
  instance_name = "ec2-instance-2"
}

output "instance_1_id" {
  value = module.ec2_instance_1.instance_id
}

output "instance_1_public_ip" {
  value = module.ec2_instance_1.public_ip
}

output "instance_2_id" {
  value = module.ec2_instance_2.instance_id
}

output "instance_2_public_ip" {
  value = module.ec2_instance_2.public_ip
}

