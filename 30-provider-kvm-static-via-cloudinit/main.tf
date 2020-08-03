provider "libvirt" {
  uri = "qemu:///system"
}
resource "libvirt_volume" "centos7-qcow2" {
  name = "centos7.qcow2"
  pool = "default"
  source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}

resource "libvirt_network" "vm_network" {
   name = "vm_network"
   addresses = ["10.0.1.0/24"]
   mode = "nat"
   dhcp {
    enabled = false
   }
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "meta_data" {
  template = file("${path.module}/network_interfaces.cfg")
}


resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  user_data = data.template_file.user_data.rendered
  meta_data = data.template_file.meta_data.rendered
}

resource "libvirt_domain" "myvm" {
  name   = "myvm"
  memory = "1024"
  vcpu   = 1
 
  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name = libvirt_network.vm_network.name
  }
  disk {
    volume_id = libvirt_volume.centos7-qcow2.id
  }
  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }
  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}

