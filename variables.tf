variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "instance_name" {
  description = "Name for the jump host instance"
  type        = string
  default     = "jump-host"
}

# SSH public key
variable "ssh_pub_key_path" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_user" {
  description = "SSH username"
  type        = string
  default     = "jumphost"
}

# Startup script configuration
variable "startup_script_path" {
  description = "Path to the startup script file relative to the module root"
  type        = string
  default     = "startup_script.sh"
  
  validation {
    condition     = can(file(var.startup_script_path))
    error_message = "The startup script file must exist and be readable."
  }
}

# Disk size configuration
variable "disk_size_gb" {
  description = "Size of the boot disk in GB"
  type        = number
  default     = 20
  
  validation {
    condition     = var.disk_size_gb >= 10 && var.disk_size_gb <= 1000
    error_message = "Disk size must be between 10 and 1000 GB."
  }
}

variable "ssh_source_ranges" {
  description = "List of CIDR ranges that are allowed to SSH into the jump host. Restrict this to known IPs for better security."
  type        = list(string)
  default     = ["0.0.0.0/0"] # WARNING: 0.0.0.0/0 allows access from any IP. Restrict this to known IPs for better security.
}
