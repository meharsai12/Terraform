variable "sg_id" {
    default = ["sg-04272fef9ce3ac807"]
  
}

variable "instances" {

    default = ["redis" , "mongodb"]
  
}

variable "common_tags" {
    default = {
        Name = "Roboshop"
        terraform = "true"
    }

  
}

variable "project" {
    default = "Roboshop"
  
}