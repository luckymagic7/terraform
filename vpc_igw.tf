# VPC
resource "aws_vpc" "task" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Name = "task"
  }
}

# IGW
resource "aws_internet_gateway" "task_igw" {
  vpc_id = "${aws_vpc.task.id}"

  tags = {
    Name = "task_igw"
  }
}
