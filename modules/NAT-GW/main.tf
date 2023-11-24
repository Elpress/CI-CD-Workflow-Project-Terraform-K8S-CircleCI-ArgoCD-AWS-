#allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-1-a
resource "aws_eip" "eip_nat_gw_a" {
  vpc = true

  tags = {
    Name = "NAT-GW-EIP-A"
  }
}

#allocate elastic ip. this eip will be used for the nat-gateway in the public subnet pub-sub-2-b
resource "aws_eip" "eip_nat_gw_b" {
  vpc = true

  tags = {
    Name = "NAT-GW-EIP-B"
  }
}

#Create a nat gateway in public subnet pub-sub-1-a
resource "aws_nat_gateway" "nat_gw_a" {
  allocation_id = aws_eip.eip_nat_gw_a.id
  subnet_id     = var.PUB_SUB_1_A_ID

  tags = {
    Name = "NAT-GW-A"
  }

  #to ensure proper ordering, it is recommend to add an explicit dependency
  depends_on = [var.IGW_ID]
}

#Create a nat gateway in public subnet pub-sub-2-b
resource "aws_nat_gateway" "nat_gw_b" {
  allocation_id = aws_eip.eip_nat_gw_b.id
  subnet_id     = var.PUB_SUB_2_B_ID

  tags = {
    Name = "NAT-GW-B"
  }

  #to ensure proper ordering, it is recommend to add an explicit dependency
  depends_on = [var.IGW_ID]
}

#Create private route table PRI_RTA_A and add route through NAT-GW-A
resource "aws_route_table" "Pri-RT-A" {
  vpc_id = var.VPC_ID

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_a.id
  }

  tags = {
    Name = "PRI-RT-A"
  }
}

#Associate private subnet PRI_SUB_3_A with a private route table Pri-RT-A
resource "aws_route_table_association" "Pri-sub-3-a-with-PRI-RT-A" {
  subnet_id      = var.PRI_SUB_3_A_ID
  route_table_id = aws_route_table.Pri-RT-A.id
}

#Create private route table PRI_RT_B and add route through NAT-GW-B
resource "aws_route_table" "Pri-RT-B" {
  vpc_id = var.VPC_ID

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw_b.id
  }

  tags = {
    Name = "PRI-RT-B"
  }
}

resource "aws_route_table_association" "Pri-sub-4-a-with-PRI-RT-B" {
  subnet_id      = var.PRI_SUB_4_B_ID
  route_table_id = aws_route_table.Pri-RT-B.id
}