module "ec2" {
  source         = "bluehackrafestefano/ec2/aws"
  version        = "4.0.0"
  key_name       = "task"
  instance_ports = var.instance_ports
}
