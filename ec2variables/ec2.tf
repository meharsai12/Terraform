resource "aws_instance" "roboshop" {
  ami           = var.image_id
  instance_type = var.instance_type
  vpc_security_group_ids = var.sg_id
  
  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_security_group" "allow" {
    name        = "allow_all"
    description = "allow all traffic"

    ingress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "allow-all"
    }
}