variable "instance1" {
  type = map
  default = {
    ip = "10.0.1.2"
    name = "instance1"
  }
}

variable "instance2" {
  type = map
  default = {
    ip = "10.0.1.3"
    name = "instance2"
    cpu       = 2
    memory    = 2048
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_network" "vm_network" {
  name = "vm_network"
  addresses = ["10.0.1.0/24"]
  mode = "nat"
  dhcp {
   enabled = false
  }
}

resource "libvirt_pool" "pool_mycentos" {
 name = "mycentos"
 type = "dir"
 path = "/disklv/images/"
}

module "instance1" {
  source    = "./modules/instances"
  ip        = var.instance1.ip
  network   = libvirt_network.vm_network.name
  name      = var.instance1.name
  pool      = libvirt_pool.pool_mycentos.name

}

module "instance2" {
  source    = "./modules/instances"
  ip        = var.instance2.ip
  network   = libvirt_network.vm_network.name
  name      = var.instance2.name
  cpu       = var.instance2.cpu
  memory    = var.instance2.memory
  pool      = libvirt_pool.pool_mycentos.name
}

