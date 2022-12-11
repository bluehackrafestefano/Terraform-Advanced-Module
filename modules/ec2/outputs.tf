output "instance_public_ips" {
  value = aws_instance.tfmyec2.*.public_ip
}

output "instance_public_ip" {
  value = aws_instance.tfmyec2.0.public_ip
}

output "sec_gr_id" {
  value = aws_security_group.tf_sec_gr.id
}

output "instance_id" {
  value = aws_instance.tfmyec2.*.id
}

output "instance_type" {
  value = aws_instance.tfmyec2.0.instance_type
}
