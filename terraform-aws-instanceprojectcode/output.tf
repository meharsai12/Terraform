output "public_ipadd" {
  value = module.ec2[*].public_ip
}

output "private_ipadd" {
  value = module.ec2[*].private_ip
}

