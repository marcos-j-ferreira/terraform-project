output "instance_id" {
    description = "The ID of the EC2 instance"
    value       = aws_instance.ec2.id
}


output "public_ip" {
    description = "The public Ip of the EC2 instance"
    value       = aws_instance.ec2.public_ip
}

