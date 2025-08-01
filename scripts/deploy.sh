#!/bin/bash
set -euo pipefail

echo "🚀 Starting complete infrastructure deployment..."

# Change to project directory
cd "$(dirname "$0")/.."

# Deploy infrastructure with Terraform
echo "📦 Deploying VM with Terraform..."
cd terraform
terraform init
terraform validate
terraform plan
terraform apply -auto-approve

# Get VM IP using the corrected method
VM_IP=$(terraform output -raw vm_ip)
echo "✅ VM deployed at IP: $VM_IP"

# Wait for VM to be ready
echo "⏳ Waiting for VM to be accessible..."
timeout=300
elapsed=0
while ! nc -z "$VM_IP" 22; do
  if [ $elapsed -ge $timeout ]; then
    echo "❌ Timeout waiting for VM to be accessible"
    exit 1
  fi
  sleep 5
  elapsed=$((elapsed + 5))
  echo "Still waiting for SSH... (${elapsed}s/${timeout}s)"
done

echo "✅ VM is accessible via SSH"

cd ../ansible

# Update inventory with actual IP
echo "📝 Updating Ansible inventory..."
sed -i "s/ansible_host: .*/ansible_host: $VM_IP/" inventory/hosts.yml

# Test Ansible connectivity
echo "🔍 Testing Ansible connectivity..."
ansible all -m ping -i inventory/hosts.yml

# Deploy services with Ansible
echo "🎯 Deploying services with Ansible..."
ansible-playbook -i inventory/hosts.yml playbooks/site.yml

echo ""
echo "🎉 Deployment complete!"
echo ""
echo "Access your services:"
echo "• Traefik Dashboard: http://$VM_IP:8080"
echo "• Portainer: http://$VM_IP:9000"
echo "• PiHole: http://$VM_IP/admin"
echo ""
echo "Next steps:"
echo "1. Configure your router to use $VM_IP as DNS server"
echo "2. Set up port forwarding for ports 80 and 443 if needed"
echo "3. Configure SSL certificates in Traefik"