output "mini3_s3_url" {
    value = aws_s3_bucket.mini3_s3.arn
}
output "mini3_s3_name" {
    value = aws_s3_bucket.mini3_s3.id
}
output "mini3_s3_bucket" {
    value = aws_s3_bucket.mini3_s3.bucket
}