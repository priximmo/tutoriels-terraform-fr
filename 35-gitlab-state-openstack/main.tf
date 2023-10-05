terraform {
  required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.1"
    }
  }
  backend "http" {
    address = "https://gitlab.com/api/v4/projects/<id_projet_gitlab>/terraform/state/<nom_du_state>"
    lock_address = "https://gitlab.com/api/v4/projects/<id_projet_gitlab>/terraform/state/<nom_du_state>/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/<id_projet_gitlab>/terraform/state/<nom_du_state>/lock"
    lock_method = "POST"
    unlock_method = "DELETE"
    retry_wait_min = 5
  }
}

resource "openstack_compute_keypair_v2" "xavki" {
  name = "xavki"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINKkmKOi1M0P7zIG5SlCzCkC/DAmoO7CsGD2ANKtH5my oki@doki"
}

resource "openstack_compute_secgroup_v2" "web" {
  name        = "web"
  description = "server web"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}


resource "openstack_compute_instance_v2" "test1" {
  name            = "my-first-vm"
  image_id        = "cdf81c97-4873-473b-b0a3-f407ce837255"
  flavor_name     = "a1-ram2-disk20-perf1"

	key_pair        = "xavki"
  
	metadata = {
    environment = "test"
  }

  security_groups = ["web"]

  network {
    name = "ext-net1"
  }
}

