data "aws_availability_zones" "available" {
  state = "available"
}


output "azs_zones" {
    value = data.aws_availability_zones.available.names
}