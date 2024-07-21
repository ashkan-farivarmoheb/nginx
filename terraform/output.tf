output "nginx-tag" {
  value = "${var.folder_name}"
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "uploaded_files" {
  value = aws_s3_object.upload_files.*.key
}