#### instances

resource "vultr_instance" "k8s_master" {
  plan     = var.k8s_master_plan
  region   = var.vultr_region
  os_id    = var.k8s_os_id
  label    = "k8s_master_node"
  tag      = "k8s master"
  hostname = "k8s_master_host"
  plan        = var.k8s_master_plan
  region      = var.vultr_region
  os_id       = var.k8s_os_id
  label       = "k8s_master_node"
  tag         = "k8s master"
  hostname    = "k8s_master_host"
  ssh_key_ids = [vultr_ssh_key.k8s_ssh_key.id]
}
