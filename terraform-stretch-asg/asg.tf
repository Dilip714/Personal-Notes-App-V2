# ---------------------------------------------------------------------------
# STRETCH GOAL: Replace the single EC2 instance (ec2.tf in ../terraform)
# with an Auto Scaling Group behind an internal Application Load Balancer.
#
# To use: remove/comment out aws_instance.app in ../terraform/ec2.tf, then
# copy these resources into that module (they reference the same VPC,
# subnets, security group and IAM instance profile already defined there).
# Kept in a separate folder here so the base project stays simple.
# ---------------------------------------------------------------------------

# Internal ALB — internal because the app lives entirely in private subnets.
resource "aws_lb" "app" {
  name               = "${var.project_name}-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app.id]
  subnets            = aws_subnet.private[*].id

  tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_target_group" "app" {
  name     = "${var.project_name}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path                = "/health"
    healthy_threshold   = 2
    unhealthy_threshold = 3
    interval            = 15
    timeout             = 5
  }
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

# Launch Template replaces the single aws_instance — same AMI, same
# user_data bootstrap script, same IAM profile and security group.
resource "aws_launch_template" "app" {
  name_prefix   = "${var.project_name}-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  vpc_security_group_ids = [aws_security_group.app.id]

  user_data = base64encode(templatefile("${path.module}/../terraform/user_data.sh.tpl", {
    docker_image = var.docker_image
    app_port     = var.app_port
  }))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.project_name}-asg-instance"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  name                = "${var.project_name}-asg"
  vpc_zone_identifier = aws_subnet.private[*].id
  target_group_arns   = [aws_lb_target_group.app.arn]

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  health_check_type         = "ELB"
  health_check_grace_period = 60

  tag {
    key                 = "Name"
    value               = "${var.project_name}-asg-instance"
    propagate_at_launch = true
  }
}

# ---------------------------------------------------------------------------
# Why this is better than a single EC2 instance:
#
# - Availability: instances span 2 AZs; losing one AZ doesn't take the app
#   down.
# - Self-healing: ASG health checks (via the ALB) replace unhealthy
#   instances automatically — no manual intervention.
# - Elastic capacity: scales from 2 to 4 instances under load instead of
#   being capped at whatever a single box can handle.
# - Zero-downtime deploys: rolling instance refresh can replace instances
#   with a new AMI/image version without an outage.
# - Cost control: desired=2 keeps steady-state cost predictable while still
#   allowing burst capacity up to 4.
# ---------------------------------------------------------------------------
