output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "folder_name" {
  value = "${var.folder_name}"
}

output "upload_conf_files" {
  value = [for obj in aws_s3_object.upload_conf_files : obj.key]
}

output "upload_crt_files" {
  value = [for obj in aws_s3_object.upload_crt_files : obj.key]
}

output "upload_key_files" {
  value = [for obj in aws_s3_object.upload_key_files : obj.key]
}