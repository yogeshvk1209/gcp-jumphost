# Firewall rule for SSH access
resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh-jumphost"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["jump-host"]
}

# Get latest CentOS image
data "google_compute_image" "centos" {
  family  = "centos-stream-9"
  project = "centos-cloud"
}

# Create the jump host instance
resource "google_compute_instance" "jump_host" {
  name         = var.instance_name
  machine_type = "e2-micro"
  zone         = var.zone

  tags = ["jump-host"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.centos.self_link
      size  = var.disk_size_gb
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  scheduling {
    automatic_restart = false
    provisioning_model = "SPOT"
    instance_termination_action = "STOP"
  }

  # Add SSH key to instance metadata
  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_pub_key_path)}"
  }

  # Use external startup script
  metadata_startup_script = file("${path.module}/${var.startup_script_path}")

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
} 