# Create SSH key resource
resource "hcloud_ssh_key" "default" {
  name       = "egle-web-key"
  public_key = file("~/.ssh/id_ed25519hetzner.pub")
}

# Create a server
resource "hcloud_server" "web" {
  name        = "egle-web"
  image       = "ubuntu-22.04"
  server_type = "cx22"
  location    = "nbg1"
  
  # Add SSH key
  ssh_keys = [hcloud_ssh_key.default.id]
  
  # Add cloud-init configuration
  user_data = file("${path.module}/cloudinit/web-setup.yml")
}

# Create a volume
resource "hcloud_volume" "storage" {
  name       = "my-volume"
  size       = 50
  server_id  = hcloud_server.web.id
  automount  = true
  format     = "ext4"
}