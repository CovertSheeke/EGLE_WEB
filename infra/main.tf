# Configure Terraform settings and required providers
terraform {
    required_providers {
        hcloud = {
            source  = "hetznercloud/hcloud"
        }
    }
    required_version = ">= 0.13"
}

# Configure the Hetzner Cloud provider with the API token
provider "hcloud" {
    token = var.hcloud_token 
}

# Allocate a new floating IPv4 address
resource "hcloud_floating_ip" "public" {
    type          = "ipv4"
    home_location = "nbg1"
}

# Assign the floating IP to the created server
resource "hcloud_floating_ip_assignment" "a" {
    floating_ip_id = hcloud_floating_ip.public.id
    server_id      = hcloud_server.web.id
}
