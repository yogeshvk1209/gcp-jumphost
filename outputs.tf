output "jump_host_ip" {
  value       = google_compute_instance.jump_host.network_interface[0].access_config[0].nat_ip
  description = "The external IP of the jump host"
}

output "ssh_command" {
  value       = "ssh -i ${path.module}/ssh-keys/jumphost-key ${var.ssh_user}@${google_compute_instance.jump_host.network_interface[0].access_config[0].nat_ip}"
  description = "SSH command to connect to the jump host"
}

output "private_key_path" {
  value       = "${path.module}/ssh-keys/jumphost-key"
  description = "Path to the generated private key"
} 