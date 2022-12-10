variable "instance_ports" {
  type        = list(any)
  default     = [8080]
  description = "security group open ports"
}
