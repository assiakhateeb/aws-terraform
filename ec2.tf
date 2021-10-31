data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# provides an EC2 instance resource. 
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  count = 2
  vpc_security_group_ids  = [aws_security_group.allow_web.id]
  user_data = file("${path.module}/scripts/update.sh")
  tags = {
    Name = "nginx-server-${count.index}"
  }
}