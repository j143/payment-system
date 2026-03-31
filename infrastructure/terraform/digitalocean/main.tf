terraform {
  required_version = ">= 1.5.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "random_password" "db_password" {
  length           = 24
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "digitalocean_ssh_key" "default" {
  name       = "${var.project_name}-key-${random_string.suffix.result}"
  public_key = var.ssh_public_key
}

resource "digitalocean_droplet" "hyperswitch" {
  name              = "${var.project_name}-${random_string.suffix.result}"
  region            = var.region
  size              = var.droplet_size
  image             = var.droplet_image
  monitoring        = true
  backups           = false
  ipv6              = false
  ssh_keys          = [digitalocean_ssh_key.default.fingerprint]
  user_data         = templatefile("${path.module}/cloud-init.yaml.tftpl", {
    hyperswitch_repo = var.hyperswitch_repo
    hyperswitch_ref  = var.hyperswitch_ref
  })
  tags              = ["hyperswitch", var.environment]
}

resource "digitalocean_firewall" "hyperswitch" {
  name        = "${var.project_name}-fw-${random_string.suffix.result}"
  droplet_ids = [digitalocean_droplet.hyperswitch.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = var.ssh_allowed_cidrs
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8080"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
