resource "aws_instance" "roboshop" {
  count                  = length(var.instances)
  ami                    = var.ami_id
  instance_type          = var.environment == "dev" ? "t3.micro" : "t3.small"
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = merge(
    var.common_tags,
    {
      Name = local.final_name
    }
  )
}

resource "aws_security_group" "allow_all" {
  name        = var.sg_name
  description = var.sg_desc

  ingress {
    from_port        = var.fromport
    to_port          = var.toport
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = var.fromport
    to_port          = var.toport
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "allow-all"
    }
  )
}