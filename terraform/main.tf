
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
    EOT
  }

  depends_on = [aws_s3_bucket.my_bucket]
}

resource "null_resource" "list_files" {
  provisioner "local-exec" {
    command = "cd ../ssl && ls -l"
  }

  depends_on = [null_resource.run_shell_script]
}

locals {
  conf_files = fileset("../ssl", "*.conf")
  crt_files  = fileset("../ssl", "*.crt")
  key_files  = fileset("../ssl", "*.key")
  pem_files  = fileset("../ssl", "*.pem")
  csr_files  = fileset("../ssl", "*.csr")
  srl_files  = fileset("../ssl", "*.srl")
  all_files  = flatten([local.conf_files, local.crt_files, local.key_files, local.pem_files, local.csr_files, local.srl_files])
}

resource "aws_s3_object" "upload_files" {
  for_each = toset(local.all_files)

  bucket = aws_s3_bucket.my_bucket.bucket
  key    = "${var.folder_name}/${each.value}"
  source = "../ssl/${each.value}"
  acl    = "private"

  depends_on = [null_resource.run_shell_script, null_resource.list_files]
}