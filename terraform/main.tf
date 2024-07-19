
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  acl    = "private"
}

resource "null_resource" "run_shell_script" {
  provisioner "local-exec" {
    command = <<EOT
      #!/bin/bash
      chmod +x ../ssl/ssl.sh
      ../ssl/ssl.sh ${var.domain_name}
    EOT
  }

  depends_on = [aws_s3_bucket.my_bucket]
}

resource "aws_s3_bucket_object" "upload_files" {
  for_each = fileset(".", "*")

  bucket = aws_s3_bucket.my_bucket.bucket
  key    = each.value
  source = "${each.value}"
  acl    = "private"

  depends_on = [null_resource.run_shell_script]
}