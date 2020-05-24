provider "digitalocean" {
  // token automatically picked up using env variable DIGITALOCEAN_ACCESS_TOKEN
}

variable "region" {
  default = "sfo2"
}

data digitalocean_ssh_key "my_ssh_key" {
  name = "thinkpad"
}

resource "digitalocean_droplet" "atest" {
  image      = "ubuntu-18-04-x64"
  name       = "test"
  region     = var.region
  size       = "s-1vcpu-2gb"
  ssh_keys   = [data.digitalocean_ssh_key.my_ssh_key.id]
  monitoring = true
  private_networking = true
}

output "droplet_ip_address" {
  value = digitalocean_droplet.atest.ipv4_address
}