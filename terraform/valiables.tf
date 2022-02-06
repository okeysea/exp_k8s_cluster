terraform {
  required_version = "= 1.1.5"

  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "2.9.1"
    }
  }
}

provider "vultr" {
  api_key     = "${var.CLOUD_VENDOR_API_KEY}"
  rate_limit  = 700
  retry_limit = 3
}

variable "CLOUD_VENDOR_API_KEY" {}
variable "vultr_region" {}
variable "k8s_master_plan" {}
variable "k8s_worker_plan" {}
variable "k8s_os_id" {}

variable "ssh_key_name" {
  type        = string
  description = "keypair name"
  default     = "k8s_keypair"
}
