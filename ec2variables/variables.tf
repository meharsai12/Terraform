variable "image_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
  
}

variable "instance_type" {
    type = string
    default = "t3.micro"
  
}

variable "sg_id" {

    default = [" aws_security_group.allow.id "]

  
}
