variable "image_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
  
}

variable "instance_type" {
    type = string
    default = "t3.micro"
  
}

variable "ec2_tags" {
    default = {
    Name = "terraform"
    purpose = "Using it is for terraform variable-demo"
  }
  
}

variable "sg_name" {
    default = "allow-alltraffic"
  
}

variable "sg_desc" {
    default = "Allowing all trafficfor inbound and outbound"
  
}

variable "fromport" {
    default = 0
  
}

variable "toport" {
    default = 0
}

variable "cidr-blocks" {

    default =  ["0.0.0.0/0"]
  
}

variable "sg_tags" {

    default = {
        Name = "terraformSg"
    }
  
}