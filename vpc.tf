resource "aws_vpc" "vpc_ecs" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = "vpc-ecs"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_ecs.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-2a"

  tags = {
    Name = "private-subnet"
  }
}
