#
#
provider "aws" {
  access_key = "AKIAJXMWCHLQPLNMB5QQ"
  secret_key = "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"
  region     = "eu-west-2"
}


data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = "ami-00c2c864"
  subnet_id     = "subnet-11dfcd6a"
  instance_type = "t2.small"
  key_name       = "mikeowens"
  vpc_security_group_ids = ["sg-2f032347"]

  tags {
    Name = "Web App Server"
  }
}


resource "aws_eip_association" "eip_assoc" {
  instance_id   = "${aws_instance.web.id}"
  allocation_id = "${aws_eip.webpub.id}"
}

resource "aws_eip" "webpub" {
  vpc = true
}
