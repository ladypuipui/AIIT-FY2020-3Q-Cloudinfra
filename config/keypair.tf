locals {
  public_key_file  = "./puipui.pub"
  private_key_file = "./puipui"
}

resource "tls_private_key" "keygen" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key_pem" {
  filename = "${local.private_key_file}"
  content  = "${tls_private_key.keygen.private_key_pem}"
  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_file}"
  }
}

resource "local_file" "public_key_openssh" {
  filename = "${local.public_key_file}"
  content  = "${tls_private_key.keygen.public_key_openssh}"
  provisioner "local-exec" {
    command = "chmod 600 ${local.public_key_file}"
  }
}

output "private_key_file" {
  value = "${local.private_key_file}"
}

output "private_key_pem" {
  value = "${tls_private_key.keygen.private_key_pem}"
}

output "public_key_file" {
  value = "${local.public_key_file}"
}

output "public_key_openssh" {
  value = "${tls_private_key.keygen.public_key_openssh}"
}
