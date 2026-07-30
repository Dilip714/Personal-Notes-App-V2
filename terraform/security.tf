# Security group for the app EC2 instance.
# No inbound rule from 0.0.0.0/0 on purpose — the instance is private.
# Inbound is restricted to the VPC CIDR only (e.g. for a future internal
# load balancer or bastion/SSM access).
resource "aws_security_group" "app" {
  name        = "${var.project_name}-app-sg"
  description = "Security group for the private Notes App EC2 instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "App port, VPC-internal only"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "SSH, VPC-internal only (bastion/SSM use)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    description = "Allow all outbound (needed to pull Docker image via S3/registry paths)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-app-sg"
  }
}
# Security Group for Interface VPC Endpoints

resource "aws_security_group" "endpoint" {
  name        = "${var.project_name}-endpoint-sg"
  description = "Security group for VPC Interface Endpoints"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-endpoint-sg"
  }
}