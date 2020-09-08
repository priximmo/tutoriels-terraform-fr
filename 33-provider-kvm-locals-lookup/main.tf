
provider "libvirt" {
  uri = "qemu:///system"
}

locals {
  net = {
    default = "10.0.2"
  }
  instance1 = {
      ip = "${lookup(local.net,"default")}.2"
      name = "instance1"
  }
  instance2 = {
      ip = "${lookup(local.net,"default")}.2"
      name = "instance2"
  }
}

resource "libvirt_pool" "pool_mycentos" {
  name = "mycentos_${terraform.workspace}"
  type = "dir"
  path = "/disklv/images/${terraform.workspace}"
}


resource "libvirt_network" "vm_network" {
  name = "vm_network_${terraform.workspace}"
  addresses = ["${lookup(local.net,"default")}.0/24"]
  mode = "nat"
  dhcp {
   enabled = false
  }
}

module "instance1" {
  source    = "./modules/instances"
  ip        = local.instance1.ip
  network   = libvirt_network.vm_network.name
  name      = "${local.instance1.name}-default"
  pool      = libvirt_pool.pool_mycentos.name
}
module "instance2" {
  source    = "./modules/instances"
  ip        = local.instance2.ip
  network   = libvirt_network.vm_network.name
  name      = "${local.instance2.name}-default"
  pool      = libvirt_pool.pool_mycentos.name
}



