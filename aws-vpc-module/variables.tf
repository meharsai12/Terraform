variable "project" {
    type = string
  
}

variable "environment" {
    type = string
  
}

variable "cidr_block" {
    default = "10.0.0.0/16"
  
}


variable "public_subnet_cidr" {
    type = list(string)
    
  
}

variable "private_subnet_cidr" {
    type = list(string)
    
  
}


variable "database_subnet_cidr" {
    type = list(string)
    
  
}


variable "public_subnet_tags" {
    default = {}
  
}

variable "private_subnet_tags" {
    default = {}
  
}

variable "database_subnet_tags" {
    default = {}
  
}



variable "igw_tags" {
    default = {}
  
}