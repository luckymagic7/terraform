# Subnet
resource "aws_subnet" "pub_a" {
  vpc_id     = "${aws_vpc.task.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub_a"
  }
}

resource "aws_subnet" "pub_c" {
  vpc_id     = "${aws_vpc.task.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-2c"
  map_public_ip_on_launch = true
  tags = {
    Name = "pub_c"
  }
}

resource "aws_subnet" "priv_a" {
  vpc_id     = "${aws_vpc.task.id}"
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name = "priv_a"
  }
}

resource "aws_subnet" "priv_c" {
  vpc_id     = "${aws_vpc.task.id}"
  cidr_block = "10.0.11.0/24"
  availability_zone = "ap-northeast-2c"
  tags = {
    Name = "priv_c"
  }
}
