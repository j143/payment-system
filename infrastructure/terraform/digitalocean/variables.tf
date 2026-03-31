variable "digitalocean_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive   = true
}

variable "project_name" {
  type        = string
  description = "Project name prefix for resources"
  default     = "hyperswitch-lab"
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "experiment"
}

variable "region" {
  type        = string
  description = "DigitalOcean region slug"
  default     = "sgp1"
}

variable "droplet_size" {
  type        = string
  description = "DigitalOcean droplet size"
  default     = "s-1vcpu-2gb"
}

variable "droplet_image" {
  type        = string
  description = "DigitalOcean image slug"
  default     = "ubuntu-22-04-x64"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key to access the droplet"
}

variable "ssh_allowed_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to SSH into the droplet"
  default     = ["0.0.0.0/0", "::/0"]
}

variable "outbound_allowed_cidrs" {
  type        = list(string)
  description = "CIDRs allowed for outbound traffic from the droplet"
  default     = ["0.0.0.0/0", "::/0"]
}

variable "hyperswitch_repo" {
  type        = string
  description = "Hyperswitch git repository"
  default     = "https://github.com/juspay/hyperswitch.git"
}

variable "hyperswitch_ref" {
  type        = string
  description = "Hyperswitch git ref to checkout"
  default     = "main"
}
