output "instance_name" {
  value = google_compute_instance.hyperswitch.name
}

output "instance_ip" {
  value = google_compute_instance.hyperswitch.network_interface[0].access_config[0].nat_ip
}

output "hyperswitch_url" {
  value = "http://${google_compute_instance.hyperswitch.network_interface[0].access_config[0].nat_ip}:8080"
}

output "generated_db_password" {
  value       = random_password.db_password.result
  sensitive   = true
  description = "Generated password available for future custom DB config"
}
