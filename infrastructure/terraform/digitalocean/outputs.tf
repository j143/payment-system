output "droplet_name" {
  value = digitalocean_droplet.hyperswitch.name
}

output "droplet_ip" {
  value = digitalocean_droplet.hyperswitch.ipv4_address
}

output "hyperswitch_url" {
  value = "http://${digitalocean_droplet.hyperswitch.ipv4_address}:8080"
}

output "generated_db_password" {
  value       = random_password.db_password.result
  sensitive   = true
  description = "Generated password available for future custom DB config"
}
