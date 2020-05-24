provider "digitalocean" {
  // token automatically picked up using env variables
}

variable "region" {
  # `doctl kubernetes options regions` for full list
  default = "sfo3"
}

data "digitalocean_kubernetes_versions" "do_k8s_versions" {}

output "k8s-versions" {
  value = data.digitalocean_kubernetes_versions.do_k8s_versions.latest_version
}

resource "digitalocean_kubernetes_cluster" "hellok8s" {
  name    = "hellok8s"
  region  = var.region
  # Or grab the latest version slug from `doctl kubernetes options versions`
  version = data.digitalocean_kubernetes_versions.do_k8s_versions.latest_version

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-2gb"
    node_count = 1
  }
}