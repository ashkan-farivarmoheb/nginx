
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  acl = "private"
}

resource "null_resource" "run_shell_script" {
  provisioner "local-exec" {
    command = <<EOT
      #!/bin/bash
      cd ../ssl
      chmod +x ./ssl.sh
      ./ssl.sh ${var.domain_name}
      ls -l # List files to confirm they were created
    EOT
  }
  depends_on = [aws_s3_bucket.my_bucket]
}

resource "aws_s3_object" "upload_files" {
  for_each = fileset("../ssl", "*")

  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "${var.folder_name}/${each.value}"
  source = "../ssl/${each.value}"
  acl    = "private"

  depends_on = [null_resource.run_shell_script]
}