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
