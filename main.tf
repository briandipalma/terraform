terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.7.1"
    }
  }
}

provider "proxmox" {
  pm_api_url = var.proxmox_api_url
  // Required when using self signed certs
  pm_tls_insecure = true
}

resource "proxmox_lxc" "basic" {
  target_node  = "pve"
  hostname     = "lxc-basic"
  ostemplate   = "local:vztmpl/ubuntu-21.04-standard_21.04-1_amd64.tar.gz"
  password     = "BasicLXCContainer"
  unprivileged = true

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}
