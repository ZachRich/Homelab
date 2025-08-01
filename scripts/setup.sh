#!/bin/bash
set -euo pipefail

echo "🚀 Setting up Proxmox Infrastructure..."

# Check prerequisites
command -v terraform >/dev/null 2>&1 || { echo "Terraform is required but not installed. Aborting." >&2; exit 1; }
command -v ansible >/dev/null 2>&1 || { echo "Ansible is required but not installed. Aborting." >&2; exit 1; }

# Create Debian template in Proxmox (run this on Proxmox host)
echo "📋 First, create a Debian template on your Proxmox server:"
echo "Run the following commands on your Proxmox host:"
echo ""
echo "# Download Debian cloud image"
echo "wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2"
echo ""
echo "# Create VM template"
echo "qm create 9000 --name debian-12-template --memory 2048 --cores 2 --net0 virtio,bridge=vmbr0"
echo "qm importdisk 9000 debian-12-generic-amd64.qcow2 local-lvm"
echo "qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0"
echo "qm set 9000 --boot c --bootdisk scsi0"
echo "qm set 9000 --ide2 local-lvm:cloudinit"
echo "qm set 9000 --serial0 socket --vga serial0"
echo "qm set 9000 --agent enabled=1"
echo "qm template 9000"
echo ""
echo "Press Enter after creating the template..."
read -r

echo "✅ Template setup complete!"