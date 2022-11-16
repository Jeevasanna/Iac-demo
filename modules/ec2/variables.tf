variable "ec2_count" {
  default = "1"
}

variable "ami_id" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "subnet_id" {}

variable "az_name"{
  default = "ap-south-1a"
}
