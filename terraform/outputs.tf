output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "ec2_instance_id" {
  value = aws_instance.app.id
}

output "ec2_private_ip" {
  value = aws_instance.app.private_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.assets.bucket
}

output "s3_vpc_endpoint_id" {
  value = aws_vpc_endpoint.s3.id
}
