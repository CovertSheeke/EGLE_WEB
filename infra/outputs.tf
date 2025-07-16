output "floating_ip_address" {
  description = "The floating IP address of the server"
  value       = hcloud_floating_ip.public.ip_address
}

output "server_name" {
  description = "The name of the server"
  value       = hcloud_server.web.name
}