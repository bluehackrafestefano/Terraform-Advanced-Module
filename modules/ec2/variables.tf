variable "instance_type" {
  type = map(string)
  default = {
    default = "t2.micro"
    dev     = "t2.small"
    prod    = "t2.medium"
  }
  description = "Adjust the instance type with workspace needs"
}

variable "key_name" {
  type        = string
  description = "Write key name without .pem"
}

variable "tags" {
  type        = string
  default     = "Ubuntu-Instance"
  description = "A tag to incicate instance os"
}

variable "server-name" {
  type    = string
  default = "ubuntu"
}

variable "instance-ports" {
  type        = list(number)
  description = "ubuntu-instance-sec-gr-inbound-rules"
  default     = []
}
