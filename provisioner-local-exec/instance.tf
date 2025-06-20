resource "aws_instance" "roboshop" {
count = length(var.instances)
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [ aws_security_group.allow_all.id ]
  provisioner "local-exec" {
    command = " echo ${self.private_ip} >> inventory.ini "
    
    }

provisioner "local-exec" {
    when = create
    command = "echo 'Instances were created '"

  
}

provisioner "local-exec" {
    when = destroy
  command = "echo ' Instances were destroyed' "
}
 
  
  tags = var.ec2_tags
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

    tags = var.sg_tags
}