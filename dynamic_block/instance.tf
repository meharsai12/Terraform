resource "aws_instance" "roboshop" {
  count = 4
  ami           = var.ami_id
  instance_type = var.environment == "dev" ? "t3.micro" : "t3.small"
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  
  tags ={
    Name = var.instances[count.index]
  }
}

resource "aws_security_group" "allow_all" {
    name        = var.sg_name
    description = var.sg_desc
    
    dynamic "ingress" {   # dynamic is to start the block
      for_each = var.ingress_block   # take values from the variables ingress_block
      content {
        from_port        = ingress.value["from_port"]    # ingress.value represents the each element from the variable from_port
        to_port          = ingress.value["to_port"]    #ingress.value represents the each element from the variable to_port
        protocol         = "-1"
        cidr_blocks      = var.cidr_blocks
        ipv6_cidr_blocks = ["::/0"]
      }
      
    }
    egress {
        from_port        = var.fromport
        to_port          = var.toport
        protocol         = "-1"
        cidr_blocks      = var.cidr_blocks
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = var.sg_tags
}