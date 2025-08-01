resource "proxmox_virtual_environment_vm" "docker_vm" {
  name        = var.vm_name
  description = "Docker host managed by Terraform"
  node_name   = var.node_name
  vm_id       = var.vm_id

  clone {
    vm_id = var.template_id
    full  = false
  }

  cpu {
    cores = 4
    type  = "host"
  }

  memory {
    dedicated = 8192
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "scsi0"
    # Remove iothread since we're not using virtio-scsi-single
    # iothread     = true
    size         = 50
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.gateway
      }
    }

    user_account {
      username = var.admin_user
      keys     = [file(var.ssh_public_key_path)]
    }
  }

  agent {
    enabled = true
  }

  tags = ["terraform", "docker", "homelab"]
}