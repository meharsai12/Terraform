module "aws_vpc" {

  source             = "../aws-vpc-module"
  project            = "roboshop"
  environment        = "dev"
  public_subnet_cidr = ["10.0.1.0/24","10.0.2.0/24"]

}