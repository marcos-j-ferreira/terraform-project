variable "ami_id" {
    description = "The AMI ID for the EC2 instance" 
    type        = string 
#   default     = {var.ami_id}
}

variable "instance_type" {
    description     = "The type of EC2 instance"
    type            = string
    default         = "t3.micro"
}

variable "instance_name" {
    description = "The name tag for the EC2 instance"
    type        = string
}


