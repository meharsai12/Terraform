terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }


  }

  backend "s3" {
    bucket = "tfprac-state-bucket1"
    key    = "vpc-test-practice"
    region = "us-east-1"
    #dynamodb_table = "tfprac-state-dynamodb"  # if you want to do it with dynamo db asdd dynamodb_table and table name
    encrypt      = true
    use_lockfile = true # we can create locking by using s3 also if you want to do it with s3 just add use_lockfile
  }


}

provider "aws" {
  # Configuration 

  region = "us-east-1"
}