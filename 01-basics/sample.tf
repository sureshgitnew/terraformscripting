provider "aws" {
  
}


variable "name" {
    default = "Helloo"

}

variable "number" {
    default = 3
}

data "aws_ami" "example" {
  most_recent      = true
  name_regex       = "Mycentosimage-7"
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["Mycentosimage-7"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
resource "aws_instance" "web" {
    ami           = "${data.aws_ami.example.image_id}"
    instance_type = "t2.micro"
    subnet_id     = "subnet-5cf86810"
    vpc_security_group_ids = ["sg-041ad910ba6ea2316"]
     key_name        = "devops"
 tags = {
    Name = "Helloworld"
 }
}
output "name" {
  value = "${var.name}"
}
output "ami" {
  value = "${data.aws_ami.example.image_id}"
}
output "instance_public_ip" {
  value = "${aws_instance.web.public_ip}"
}