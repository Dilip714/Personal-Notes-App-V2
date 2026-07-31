output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "asg_name" {
  value = aws_autoscaling_group.app.name
}

output "target_group_arn" {
  value = aws_lb_target_group.app.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.assets.bucket
}

output "s3_vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}
