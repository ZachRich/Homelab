resource "proxmox_virtual_environment_vm" "docker_vm" {
  name        = "docker-${var.environment}"
  description = "Docker host managed by Terraform"
  node_name   = var.node_name
  vm_id       = var.vm_id

  # Clone from pre-configured template
  clone {
    vm_id = var.template_id
    full  = false  # Linked clone for faster deployment
  }

  # Resource allocation
  cpu {
    cores = 4
    type  = "host"
  }

  memory {
    dedicated = 8192
  }

  # Network with VLAN support
  network_device {
    bridge   = "vmbr0"
    vlan_id  = var.vlan_id
    model    = "virtio"
  }

  # System disk
  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    iothread     = true
    ssd          = true
    size         = 50
  }

  # Docker data disk
  disk {
    datastore_id = "local-lvm"
    interface    = "scsi1"
    iothread     = true
    ssd          = true
    size         = 200
  }

  # Cloud-init configuration
  initialization {
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.cloud_config.id
  }

  # Enable QEMU agent for better integration
  agent {
    enabled = true
  }

  # Serial console support
  serial_device {
    device = "socket"
  }

  vga {
    type = "serial0"
  }

  tags = ["terraform", "docker", var.environment]
}