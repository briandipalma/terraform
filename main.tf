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
  ostype = "ubuntu"

  // Terraform will crash without rootfs defined
  rootfs {
    storage = "local-lvm"
    size    = "8G"
  }

  mountpoint {
    mp      = "/mnt/container/bind-mount-point"
    size    = "8G"
    slot    = 0
    key     = "0"
    storage = "/srv/test"
    // Without 'volume' defined, Proxmox will try to create a volume with
    // the value of 'storage' + : + 'size' (without the trailing G) - e.g.
    // "/srv/host/bind-mount-point:256".
    // This behaviour looks to be caused by a bug in the provider.
    volume  = "/srv/test"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
  }
}
