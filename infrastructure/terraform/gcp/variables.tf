variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
  default     = "asia-southeast1"
}

variable "zone" {
  type        = string
  description = "GCP zone"
  default     = "asia-southeast1-b"
}

variable "resource_prefix" {
  type        = string
  description = "Prefix for GCP resource names"
  default     = "hyperswitch-lab"
}

variable "machine_type" {
  type        = string
  description = "Compute instance type"
  default     = "e2-medium"
}

variable "disk_size_gb" {
  type        = number
  description = "Boot disk size in GB"
  default     = 30
}

variable "image" {
  type        = string
  description = "Boot disk image"
  default     = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "network" {
  type        = string
  description = "VPC network name"
  default     = "default"
}

variable "ssh_allowed_cidrs" {
  type        = list(string)
  description = "CIDRs allowed for SSH access"
}

variable "app_allowed_cidrs" {
  type        = list(string)
  description = "CIDRs allowed to access application ports"
}

variable "ssh_user" {
  type        = string
  description = "SSH username"
  default     = "ubuntu"
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key"
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
