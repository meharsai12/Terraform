variable "ami_id" {
    default = "ami-09c813fb71547fc4f"
  
}

variable "instance_type" {
    default = "t3.micro"

    validation {
      condition     = contains(["t3.micro", "t3.small", "t3.medium"], var.instance_type)
        error_message = "Valid values for instance_type are: t3.micro, t3.small, t3.medium"
    }
  
}

variable "ec2_tags" {
    type = map
  }

variable "sg_ids" {
    type = list
  
}
  