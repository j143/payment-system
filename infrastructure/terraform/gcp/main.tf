terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "random_password" "db_password" {
  length  = 24
  special = false
}

resource "google_compute_firewall" "hyperswitch" {
  name    = "${var.resource_prefix}-fw-${random_string.suffix.result}"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080"]
  }

  source_ranges = var.allowed_cidrs
  target_tags   = ["hyperswitch"]
}

resource "google_compute_instance" "hyperswitch" {
  name         = "${var.resource_prefix}-${random_string.suffix.result}"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["hyperswitch"]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size_gb
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = var.network

    access_config {}
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${var.ssh_public_key}"
  }

  metadata_startup_script = templatefile("${path.module}/startup.sh.tftpl", {
    hyperswitch_repo = var.hyperswitch_repo
    hyperswitch_ref  = var.hyperswitch_ref
  })

}
