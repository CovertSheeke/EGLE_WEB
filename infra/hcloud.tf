# Create a server
resource "hcloud_server" "web" {
  name        = "egle-web"
  image       = "ubuntu-22.04"
  server_type = "cx22"
  location    = "nbg1"
}