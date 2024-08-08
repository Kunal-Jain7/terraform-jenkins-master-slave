# Terraform code for creating New VPC and the required resources
resource "aws_vpc" "client-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = format("%s-vpc", var.stack_env)
  }
}

# Public Subnet Creation
resource "aws_subnet" "client-pub-sub" {
  vpc_id            = aws_vpc.client-vpc.id
  count             = length(var.cidr_public_subnet)
  cidr_block        = element(var.cidr_public_subnet, count.index)
  availability_zone = element(var.eu_availibility_zone, count.index)

  tags = {
    Name = format("%s-pub-sub-${count.index + 1}", var.stack_env)
  }
}

# Private Subnet Creation
resource "aws_subnet" "client-prv-sub" {
  vpc_id            = aws_vpc.client-vpc.id
  count             = length(var.cidr_private_subnet)
  cidr_block        = element(var.cidr_private_subnet, count.index)
  availability_zone = element(var.eu_availibility_zone, count.index)

  tags = {
    Name = format("%s-prv-sub-${count.index + 1}", var.stack_env)
  }
}

# Internet Gateway Creation
resource "aws_internet_gateway" "client-igw" {
  vpc_id = aws_vpc.client-vpc.id
  tags = {
    Name = format("%s-client-igw", var.stack_env)
  }
}

# Route Table Public
resource "aws_route_table" "client-rt" {
  vpc_id = aws_vpc.client-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.client-igw.id
  }
  tags = {
    Name = format("%s-client-public-rt", var.stack_env)
  }
}

# Public Route table and Public Subnet Association
resource "aws_route_table_association" "client-pub-rt-subnet-association" {
  count          = length(aws_subnet.client-pub-sub)
  subnet_id      = aws_subnet.client-pub-sub[count.index].id
  route_table_id = aws_route_table.client-rt.id
}

# Private Route table
resource "aws_route_table" "client-prv-route" {
  vpc_id = aws_vpc.client-vpc.id
  tags = {
    Name = format("%s-client-private-rt", var.stack_env)
  }
}

# Private route table and private subnet association
resource "aws_route_table_association" "client-prv-rt-subnet-association" {
  count          = length(aws_subnet.client-prv-sub)
  subnet_id      = aws_subnet.client-prv-sub[count.index].id
  route_table_id = aws_route_table.client-prv-route.id
}