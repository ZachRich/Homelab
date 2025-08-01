output "vm_ip" {
  description = "VM IP address without CIDR"
  value       = split("/", var.ip_address)[0]
}

output "vm_id" {
  description = "VM ID"
  value       = proxmox_virtual_environment_vm.docker_vm.vm_id
}

output "vm_name" {
  description = "VM name"
  value       = proxmox_virtual_environment_vm.docker_vm.name
}

output "vm_ip_with_cidr" {
  description = "VM IP address with CIDR"
  value       = var.ip_address
}