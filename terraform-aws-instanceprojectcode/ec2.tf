module "ec2" {
    count = length(var.instances)
  source = "../terraform-aws-module"
  sg_ids = var.sg_id
  #instance_type = "t3.mediium"
  ec2_tags = merge(
    var.common_tags,
    {
        Name = "${var.instances[count.index]}-${var.project}-dev"
        component = "${var.instances[count.index]}"
    }
  )

}