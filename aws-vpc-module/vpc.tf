#roboshop-dev   \vpc creation
resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = "true"

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-1"
    }
  )
}

#roboshop-dev  /igw creation
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id #associate with VPC

  tags =  merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}"
    }
  )
}

#roboshop-dev or prod or qa -public-us-east-1a or 1b  /subnets creation
 resource "aws_subnet" "public" {
      count = length(var.public_subnet_cidr)
   vpc_id     = aws_vpc.main.id
   cidr_block = var.public_subnet_cidr[count.index]
   availability_zone = slice(data.aws_availability_zones.available.names , 0 , 2)[count.index]

   tags = merge(
    local.common_tags ,{
    Name = "${var.project}-${var.environment}-public-${slice(data.aws_availability_zones.available.names , 0 , 2)[count.index]}"

    }
   )
 } 