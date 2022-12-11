# This may be a golden image for company's use case.
data "aws_ami" "ubuntu" {
  owners      = ["099720109477"] # Canonical
  most_recent = true
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

data "template_file" "userdata" {
  template = file("${abspath(path.module)}/userdata.sh")
  vars = {
    server-name = var.server_name
  }
}

resource "aws_instance" "tfmyec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = lookup(var.instance_type, terraform.workspace)
  count                  = terraform.workspace == "prod" ? 3 : 1
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.tf_sec_gr.id]
  user_data              = data.template_file.userdata.rendered
  tags = {
    Name = var.tags
  }
}

resource "aws_security_group" "tf_sec_gr" {
  name = "terraform-sec-grp"
  tags = {
    Name = var.tags
  }
  # A loop to iterate on port list
  dynamic "ingress" {
    for_each = var.instance_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}