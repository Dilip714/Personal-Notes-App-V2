# ---------------------------------------------------------------------------
# Gateway VPC Endpoint for S3
# ---------------------------------------------------------------------------
# A Gateway Endpoint adds a target (vpce-xxxx) directly into a route table's
# prefix-list route for S3. It does NOT need an ENI, security group, or
# public IP, and — unlike an Interface Endpoint — it costs nothing extra to
# use (no hourly or per-GB endpoint charge).
#
# By attaching it to the PRIVATE route table, any instance in the private
# subnets can reach S3 (GetObject, PutObject, etc.) entirely within the AWS
# network backbone — no NAT Gateway, no Internet Gateway, no public IP.
resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private.id
  ]

  tags = {
    Name = "${var.project_name}-s3-gateway-endpoint"
  }
}
# ---------------------------------------------------------------------------
# Interface VPC Endpoints for AWS Systems Manager
# ---------------------------------------------------------------------------

locals {
  private_subnet_ids = [
    aws_subnet.private[0].id,
    aws_subnet.private[1].id
  ]
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.aws_region}.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = local.private_subnet_ids
  security_group_ids  = [aws_security_group.endpoint.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}-ssm-endpoint"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.aws_region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = local.private_subnet_ids
  security_group_ids  = [aws_security_group.endpoint.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}-ssmmessages-endpoint"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${var.aws_region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = local.private_subnet_ids
  security_group_ids  = [aws_security_group.endpoint.id]
  private_dns_enabled = true

  tags = {
    Name = "${var.project_name}-ec2messages-endpoint"
  }
}