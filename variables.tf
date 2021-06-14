variable "proxmox_api_url" {
  default = "https://pve.test:8006/api2/json"
  type = string
  description = "The Proxmox API URL"
}

variable "proxmox_user" {
  type = string
  description = "The Proxmox user"
}

variable "proxmox_password" {
  type = string
  description = "The Proxmox user password"
}
