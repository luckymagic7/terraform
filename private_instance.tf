resource "aws_security_group" "sg_for_private" {
  name = "sg_for_private"
  description = "security group for private instances"
  vpc_id      = "${aws_vpc.task.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.bastion_ssh.id}"]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.allow_80_port.id}"]
  }
  egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
  tags = {
    Name = "sg_for_private"
  }
}

resource "aws_instance" "prvi_a" {
  ami = "ami-095ca789e0549777d"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.web_admin.key_name}"
  subnet_id = "${aws_subnet.priv_a.id}"
  vpc_security_group_ids = [
    "${aws_security_group.sg_for_private.id}"
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    iops = 100
  }
  volume_tags = {
    Name = "a"
  }
  tags = {
    Name = "priv_a"
  }
}

resource "aws_instance" "prvi_c" {
  ami = "ami-095ca789e0549777d"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.web_admin.key_name}"
  subnet_id = "${aws_subnet.priv_c.id}"
  vpc_security_group_ids = [
    "${aws_security_group.sg_for_private.id}"
  ]
  root_block_device {
    volume_type = "gp2"
    volume_size = 8
    iops = 100
  }
  volume_tags = {
    Name = "c"
  }
  tags = {
    Name = "priv_c"
  }
}

resource "null_resource" "install_nginx_app_a" {
  connection {
    bastion_host = "${aws_instance.bastion.public_ip}"
    bastion_user = "ec2-user"
    bastion_private_key = "${file("~/.ssh/web_admin")}"
    host = "${aws_instance.prvi_a.private_ip}"
    user     = "ec2-user"
    private_key = "${file("~/.ssh/web_admin")}"
    agent = "false"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1.12 -y",
      "sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.ori",
      "mkdir ~/bin"
    ]
  }
  provisioner "file" {
    source = "~/task"
    destination = "~/bin/task"
  }
  provisioner "file" {
    source = "~/nginx.conf"
    destination = "~/nginx.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mv ~/nginx.conf /etc/nginx/nginx.conf",
      "sudo chown root.root /etc/nginx/nginx.conf",
      "sudo service nginx start",
      "chmod +x ~/bin/task",
      "nohup ~/bin/task &",
      "sleep 1"
    ]
  }
  
}

resource "null_resource" "install_nginx_app_c" {
  connection {
    bastion_host = "${aws_instance.bastion.public_ip}"
    bastion_user = "ec2-user"
    bastion_private_key = "${file("~/.ssh/web_admin")}"
    host = "${aws_instance.prvi_c.private_ip}"
    user     = "ec2-user"
    private_key = "${file("~/.ssh/web_admin")}"
    agent = "false"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install nginx1.12 -y",
      "sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.ori",
      "mkdir ~/bin"
    ]
  }
  provisioner "file" {
    source = "~/task"
    destination = "~/bin/task"
  }
  provisioner "file" {
    source = "~/nginx.conf"
    destination = "~/nginx.conf"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mv ~/nginx.conf /etc/nginx/nginx.conf",
      "sudo chown root.root /etc/nginx/nginx.conf",
      "sudo service nginx start",
      "chmod +x ~/bin/task",
      "nohup ~/bin/task &",
      "sleep 1"
    ]
  }
  
}
