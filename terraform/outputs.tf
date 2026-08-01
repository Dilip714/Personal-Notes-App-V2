output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = aws_subnet.private[*].id
}

output "ec2_instance_id" {
  description = "Standalone EC2 instance ID when ASG mode is disabled"
  value       = var.enable_asg ? null : aws_instance.app[0].id
}

output "ec2_private_ip" {
  description = "Standalone EC2 private IP when ASG mode is disabled"
  value       = var.enable_asg ? null : aws_instance.app[0].private_ip
}

output "alb_dns_name" {
  description = "Public ALB DNS name when ASG mode is enabled"
  value       = var.enable_asg ? aws_lb.app[0].dns_name : null
}

output "asg_name" {
  description = "Auto Scaling Group name when ASG mode is enabled"
  value       = var.enable_asg ? aws_autoscaling_group.app[0].name : null
}

output "target_group_arn" {
  description = "ALB Target Group ARN when ASG mode is enabled"
  value       = var.enable_asg ? aws_lb_target_group.app[0].arn : null
}

output "s3_bucket_name" {
  description = "S3 artifact/static assets bucket"
  value       = aws_s3_bucket.assets.bucket
}

output "s3_vpc_endpoint_id" {
  description = "S3 Gateway VPC Endpoint ID"
  value       = aws_vpc_endpoint.s3.id
}