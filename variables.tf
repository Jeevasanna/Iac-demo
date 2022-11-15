variable "aws_region" {
  description = "my aws in mumbai region"
  default     = "ap-south-1"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     =  "Anantapur"
}

variable "instance_type" {
  description = "instance type of ec2"
  default     =  "t2.micro"
}

variable "security_group" {
  description = "Name of security group"
  default     = "mysg"
}

variable "tag_name" {
  description = "Tag Name of for Ec2 instance"
  default     = "LTI-Bangalore"
}

variable "ami_id" {
  description = "AMI for Ubuntu Ec2 instance"
  default     = "ami-0e6329e222e662a52"
}
