/*==== The VPC ======*/
resource "aws_vpc" "testvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name        = "testvpc"
  }
}
# Create 2 public subnets in the testvpc
resource "aws_subnet" "testvpc-public-1" {
    vpc_id = aws_vpc.testvpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-west-1b"
    tags = {
      Name = "testvpc-public-1"
    }
  
}

resource "aws_subnet" "testvpc-public-2" {
    vpc_id = aws_vpc.testvpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-west-1c"
    tags = {
      Name = "testvpc-public-2"
    }
  
}
# Create 2 private subnets in the testvpc
resource "aws_subnet" "testvpc-private-1" {
    vpc_id = aws_vpc.testvpc.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = false
    availability_zone = "us-west-1b"
    tags = {
      Name = "testvpc-private-1"
    }
  
}


resource "aws_subnet" "testvpc-private-2" {
    vpc_id = aws_vpc.testvpc.id
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = false
    availability_zone = "us-west-1c"
    tags = {
      Name = "testvpc-private-2"
    }
  
}

#Define the internet gateway
resource "aws_internet_gateway" "testvpc-gw" {
    vpc_id = aws_vpc.testvpc.id
    tags = {
      Name = "testvpc-ig"
    }
  
}
#Define routing table 
resource "aws_route_table" "testvpc-r" {
    vpc_id = aws_vpc.testvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.testvpc-gw.id
    }
    tags = {
      Name = "testvpc-public-r"
    }
  
}
#Define routing association
resource "aws_route_table_association" "testvpc-public-1-a" {
  subnet_id      = aws_subnet.testvpc-public-1.id
  route_table_id = aws_route_table.testvpc-r.id
}

resource "aws_route_table_association" "testvpc-public-2-a" {
  subnet_id      = aws_subnet.testvpc-public-2.id
  route_table_id = aws_route_table.testvpc-r.id
}