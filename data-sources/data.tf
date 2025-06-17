data "aws_ami" "myami" {
  owners           = ["010928200701"]
  most_recent      = true

  filter {
    name   = "name"
    values = ["AutoscalinggroupAMI"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

output "ami_id" {
  value       = data.aws_ami.myami.id
}