variable "proxmox_api_url" {
  default = "https://pve.test:8006/api2/json"
  type = string
  description = "The Proxmox API URL"
}

variable "proxmox_user" {
  default = "root@pam"
  type = string
  description = "The Proxmox user"
}

variable "proxmox_password" {
  type = string
  description = "The Proxmox user password"
}

variable "pub_ssh_key" {
  default = "~/.ssh/id_ed25519.pub"
  type = string
  description = "The Proxmox user password"
}
