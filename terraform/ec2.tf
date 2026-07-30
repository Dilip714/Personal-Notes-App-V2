data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

# EC2 instance deployed into the FIRST private subnet.
# Critical: no `associate_public_ip_address` — this instance has no
# public IP and no route to the internet. All setup and image pulls
# happen through the S3 Gateway Endpoint + Docker Hub reachability
# (Docker Hub itself requires internet egress via NAT in a real prod
# setup if you pull directly from Docker Hub; here we keep the design
# minimal and note where a NAT Gateway would be added if the image were
# NOT already staged in S3 — see README "Design Notes").
resource "aws_instance" "app" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private[0].id
  vpc_security_group_ids      = [aws_security_group.app.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  key_name                    = var.key_pair_name != "" ? var.key_pair_name : null
  associate_public_ip_address = false

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    docker_image = var.docker_image
    app_port     = var.app_port
  })

  tags = {
    Name = "${var.project_name}-app-server"
  }
}
