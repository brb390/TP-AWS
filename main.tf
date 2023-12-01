#AWS Provider
provider "aws" {
  region = "eu-west-1"
}

#Création vpc

resource "aws_vpc" "bilalvpc" {
  cidr_block          = "20.0.0.0/16"
  enable_dns_support  = true
  enable_dns_hostnames = true

  tags = {
    Name = "BR1"
  }
}

#Création subnet 

resource "aws_subnet" "subnetbilal1" {
  vpc_id                  = aws_vpc.bilalvpc.id
  cidr_block              = "20.0.1.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnetbilal1"
  }
}

resource "aws_subnet" "subnetbilal2" {
  vpc_id                  = aws_vpc.bilalvpc.id
  cidr_block              = "20.0.2.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnetbilal2"
  }
}

resource "aws_subnet" "subnetbilal3" {
  vpc_id                  = aws_vpc.bilalvpc.id
  cidr_block              = "20.0.3.0/24"
  availability_zone       = "eu-west-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnetbilal3"
  }
}

#Création de la table de routage 

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.bilalvpc.id

  tags = {
    Name = "MyRouteTable"
  }
}

#Création de la tables d'associations

resource "aws_route_table_association" "subnet_association1" {
  subnet_id      = aws_subnet.subnetbilal1.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "subnet_association2" {
  subnet_id      = aws_subnet.subnetbilal2.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table_association" "subnet_association3" {
  subnet_id      = aws_subnet.subnetbilal3.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.bilalvpc.id

  tags = {
    Name = "MyInternetGateway"
  }
}

resource "aws_route" "internet_gateway_route" {
  route_table_id =aws_route_table.my_route_table.id
  destination_cidr_block= "0.0.0.0/0"
  gateway_id     =aws_internet_gateway.my_internet_gateway.id 
  }

