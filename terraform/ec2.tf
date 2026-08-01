# ---------------------------------------------------------------------------
# Latest Amazon Linux 2023 AMI
# ---------------------------------------------------------------------------

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

# ---------------------------------------------------------------------------
# Base Deployment - Single Private EC2
#
# Created only when enable_asg = false.
# When the stretch goal is enabled, the Auto Scaling Group replaces this
# standalone EC2 instance.
# ---------------------------------------------------------------------------

resource "aws_instance" "app" {
  count = var.enable_asg ? 0 : 1

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private[0].id
  vpc_security_group_ids      = [aws_security_group.app.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  key_name                    = var.key_pair_name != "" ? var.key_pair_name : null
  associate_public_ip_address = false

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    bucket_name = aws_s3_bucket.assets.bucket
    app_port    = var.app_port
    depends_on = [
      aws_s3_object.docker_image_archive,
      aws_vpc_endpoint.s3
    ]
  })

  tags = {
    Name = "${var.project_name}-app-server"
  }
}