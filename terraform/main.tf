locals {
  ssh_config_file = "/root/ssh_config/config"
}

#### SSH key
resource "vultr_ssh_key" "k8s_ssh_key" {
  name    = "k8s_cluster_ssh_key"
  ssh_key = tls_private_key.keygen.public_key_openssh
}

#### instances

resource "vultr_instance" "k8s_master" {
  plan        = var.k8s_master_plan
  region      = var.vultr_region
  os_id       = var.k8s_os_id
  label       = "k8s_master_node"
  tag         = "k8s master"
  hostname    = "k8s_master_host"
  ssh_key_ids = [vultr_ssh_key.k8s_ssh_key.id]
}

#### make ssh config
resource "local_file" "ssh_config" {
  filename = local.ssh_config_file
  content  = <<-EOF
  Host ${vultr_instance.k8s_master.label}
      Hostname ${vultr_instance.k8s_master.main_ip}
      IdentityFile ${local.private_key_file}
  EOF

  provisioner "local-exec" {
    command = "chmod 600 ${local.ssh_config_file}"
  }
}
