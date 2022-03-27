#Define external ip
resource "aws_eip" "testvpc-nat" {
  vpc = true
}

resource "aws_nat_gateway" "testvpc-nat-gw" {
    allocation_id = aws_eip.testvpc-nat.id
    subnet_id = aws_subnet.testvpc-public-1.id
    depends_on =[aws_internet_gateway.testvpc-gw]
  
}

resource "aws_route_table" "testvpc-private" {
    vpc_id = aws_vpc.testvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.testvpc-nat-gw.id
    }
    tags = {
        Name = "testvpc-private"
    }
  
}
resource "aws_route_table_association" "testvpc-private-2-a" {
  subnet_id      = aws_subnet.testvpc-private-1.id
  route_table_id = aws_route_table.testvpc-private.id
} 