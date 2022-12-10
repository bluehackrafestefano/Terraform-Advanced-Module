output "instance_public_ip" {
  value = module.ec2.instance_public_ip
}

output "instance_public_ips" {
  value = module.ec2.instance_public_ips
}

output "instance_id" {
  value = module.ec2.instance_id
}

output "instance_type" {
  value = module.ec2.instance_type
}
