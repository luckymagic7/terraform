resource "aws_key_pair" "web_admin" {
  key_name = "web_admin"
  public_key = "${file("~/.ssh/web_admin.pub")}"
}

resource "aws_security_group" "bastion_ssh" {
  name = "bastion_ssh"
  description = "Allow SSH port from all"
  vpc_id      = "${aws_vpc.task.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
  tags = {
    Name = "bastion_ssh"
  }
}

resource "aws_instance" "bastion" {
  ami = "ami-095ca789e0549777d"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.web_admin.key_name}"
  subnet_id = "${aws_subnet.pub_a.id}"
  vpc_security_group_ids = [
    "${aws_security_group.bastion_ssh.id}"
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    iops = 100
  }
  volume_tags = {
    Name = "bastion"
  }
  tags = {
    Name = "bastion"
  }
}

resource "null_resource" "ssh_key" {
  connection {
    host = "${aws_instance.bastion.public_ip}"
    user     = "ec2-user"
    private_key = "${file("~/.ssh/web_admin")}"
    agent = "false"
  }
  provisioner "file" {
    source = "~/.ssh/web_admin"
    destination = "~/web_admin"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 0400 ~/web_admin"
]
}
}
