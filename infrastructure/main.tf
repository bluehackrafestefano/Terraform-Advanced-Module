module "ec2" {
  source         = "bluehackrafestefano/ec2/aws"
  version        = "3.2.0"
  key_name       = "task"
  instance-ports = var.instance_ports
}
