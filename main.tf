resource "proxmox_lxc" "basic" {
  target_node  = "pve"
  hostname     = "jellyfin"
  ostemplate   = "local:vztmpl/ubuntu-21.04-standard_21.04-1_amd64.tar.gz"
  unprivileged = true
  ostype = "ubuntu"
  ssh_public_keys = file(var.pub_ssh_key)

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
    ip     = "192.168.1.10/24"
  }
}
