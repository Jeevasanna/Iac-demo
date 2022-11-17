resource "aws_vpc" "myvpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.tenancy}"

  tags = {
    Name = "myvpc"
  }
}

#private subnet
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "192.168.1.0/24"
  availability_zone = "${var.az_name}"
  tags = {
    Name = "Private"
  }
}

#Nat subnet
resource "aws_subnet" "nat" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "192.168.2.0/24"
  availability_zone = "${var.az_name}"
  tags = {
    Name = "NAT"
  }
}

#public subnet
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "192.168.3.0/24"
  availability_zone = "${var.az_name}"
  tags = {
    Name = "Public"
  }
}


# Internet Gateway
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myigw"
  }
}

# Route table: attach Internet Gateway
resource "aws_route_table" "mypublic_rt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  }
  tags = {
    Name = "publicRouteTable"
  }
}

# Route table: private subnet
resource "aws_route_table" "myprivate_rt" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "privateRouteTable"
  }
}



# Route table association with private subnets
resource "aws_route_table_association" "pvt_RT_asso" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.myprivate_rt.id
}

# Route table association with public subnets
resource "aws_route_table_association" "pub_RT_asso" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.mypublic_rt.id
}

