# Proxmox connection details
proxmox_endpoint = "https://192.168.86.21:8006/api2/json"
proxmox_api_token = "terraform@pve!terraform-token=bdf898ab-5c58-4765-9c2a-35c7a927568e"
proxmox_insecure = true  # Set to false if you have valid certificates

# Proxmox configuration
node_name = "pve"  # Your Proxmox node name
template_id = 9000  # Your Debian template ID (see setup below)

# VM configuration
vm_id = 100
vm_name = "docker-homelab"
# Change from 192.168.1.x to 192.168.86.x
ip_address = "192.168.86.100/24"  # Or any available IP on your network
gateway = "192.168.86.1"          # Your router's IP

# User configuration
admin_user = "debian"
ssh_public_key_path = "~/.ssh/proxmox_key.pub"