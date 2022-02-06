#
# SSH KEYS #################################
#
output "ssh_key_name" {
  value = var.ssh_key_name
}

output "ssh_public_file" {
  value = local.public_key_file
}

output "ssh_private_file" {
  value = local.private_key_file
}

output "ssh_key" {
  value     = tls_private_key.keygen
  sensitive = true
}
