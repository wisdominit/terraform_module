resource "aws_vpc" "terra_vpc" {
  cidr_block = var.my_cidr_block

  tags = {
    Name = "my-terra-vpc"
  }
}

resource "aws_subnet" "my_terra_subnet" {
  cidr_block = var.my_subnet
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "terra_subnet"
  }
}

resource "aws_internet_gateway" "my_terra_gateway" {
  vpc_id = aws_vpc.terra_vpc.id

  tags = {
    Name = "terra_gw"
  }
}

resource "aws_route_table" "my_terra_route_table" {
  vpc_id = aws_vpc.terra_vpc.id

  route {
    cidr_block = var.default_route
    gateway_id = aws_internet_gateway.my_terra_gateway.id
  }
}

resource "aws_route_table_association" "terra_route_ass" {
  subnet_id = aws_subnet.my_terra_subnet.id
  route_table_id = aws_route_table.my_terra_route_table.id
}

