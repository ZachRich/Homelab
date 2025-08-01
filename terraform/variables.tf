variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
}

variable "proxmox_api_token" {
  description = "Proxmox API token"
  type        = string
  sensitive   = true
}

variable "proxmox_insecure" {
  description = "Allow insecure connections"
  type        = bool
  default     = false
}

variable "proxmox_ssh_user" {
  description = "SSH user for Proxmox"
  type        = string
  default     = "root"
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
  default     = "pve"
}

variable "vm_id" {
  description = "VM ID"
  type        = number
  default     = 100
}

variable "template_id" {
  description = "Template VM ID"
  type        = number
  default     = 9000
}

variable "vm_name" {
  description = "VM name"
  type        = string
  default     = "docker-homelab"
}

variable "ip_address" {
  description = "VM IP address"
  type        = string
  default     = "192.168.1.100/24"
}

variable "gateway" {
  description = "Network gateway"
  type        = string
  default     = "192.168.1.1"
}

variable "admin_user" {
  description = "Admin user for VM"
  type        = string
  default     = "debian"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/proxmox_key.pub"
}