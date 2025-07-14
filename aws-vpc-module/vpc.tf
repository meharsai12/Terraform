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

  tags =  merge(  var.igw_tags,
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
  map_public_ip_on_launch = true
   tags = merge(  var.public_subnet_tags,
    local.common_tags ,{
    Name = "${var.project}-${var.environment}-public-${slice(data.aws_availability_zones.available.names , 0 , 2)[count.index]}"

    }
   )
 } 

#roboshop-dev 0r prod -private-us-east-1a or 1b
 resource "aws_subnet" "private" {
      count = length(var.private_subnet_cidr)
   vpc_id     = aws_vpc.main.id
   cidr_block = var.private_subnet_cidr[count.index]
   availability_zone = slice(data.aws_availability_zones.available.names , 0 , 2)[count.index]

   tags = merge(  var.private_subnet_tags,
    local.common_tags ,{
    Name = "${var.project}-${var.environment}-private-${slice(data.aws_availability_zones.available.names , 0 , 2)[count.index]}"

    }
   )
 }



#roboshop-dev 0r prod -privatedatabase-us-east-1a or 1b
 resource "aws_subnet" "database" {
      count = length(var.database_subnet_cidr)
   vpc_id     = aws_vpc.main.id
   cidr_block = var.database_subnet_cidr[count.index]
   availability_zone = slice(data.aws_availability_zones.available.names , 0 , 2)[count.index]

   tags = merge(  var.database_subnet_tags,
    local.common_tags ,{  
    Name = "${var.project}-${var.environment}-database-${slice(data.aws_availability_zones.available.names , 0 , 2)[count.index]}"

    }
   )
 }



resource "aws_eip" "e_ip" {
  domain   = "vpc"
  tags = merge(local.common_tags ,{  
    Name = "${var.project}-${var.environment}-eip"

    }
    )
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.e_ip.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(local.common_tags ,{  
    Name = "${var.project}-${var.environment}-nat"

    }
    )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.main]
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags ,{  
    Name = "${var.project}-${var.environment}-public_route"

    }
    )
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags ,{  
    Name = "${var.project}-${var.environment}-private_route"

    }
    )
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.common_tags ,{  
    Name = "${var.project}-${var.environment}-database_route"

    }
    )
}


resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.main.id
}


resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}

resource "aws_route" "database" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}




resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidr)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}

    