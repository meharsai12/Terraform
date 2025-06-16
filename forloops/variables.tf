variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
  
}

variable "instance_type" {
    default = "t3.micro"
  
}

variable "ec2_tags" {
    default =  {
    Name = "Terraform loops"
    purpose = "It is using for ec2 instance"
  }
  
}

variable "sg_name" {

    default = "allowall_ports"
  
}

variable "sg_desc" {

    default = "It allows all traffaic from all ports to inbound and outbound"

  
}

variable "fromport" {

    default = 0
  
}

variable "toport" {
  default = 0
}

variable "cidr_blocks" {
  
  default = ["0.0.0.0/0"]
}

variable "sg_tags" {

    default = {
        Name = "allow-all"
        purpose = "all ports open it is used for all the ports open for ths sg group"
    }
  
}


variable "environment" {

    default = "dev"
  
}

variable "instances" {

    default = ["mongodb", "redis" , "frontend" , "rabbitmq"]
  
}

variable "zone_id" {
    default = "Z087991113U7C6A5OTRJB"
  
}

variable "domain_name" {

    default = "meharsai.site"
  
}