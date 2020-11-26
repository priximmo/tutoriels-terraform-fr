%title: Terraform
%author: xavki


# KVM : IP static via Cloud-Init


<br>


* création d'un réseau

```
resource "libvirt_network" "vm_network" {
   name = "vm_network"
   addresses = ["10.0.1.0/24"]
   mode = "nat"
   dhcp {
    enabled = false
   }
}
```

Rq :désactivation du dhcp sur le réseau (entier)

<br>


* ajout d'un cloud init "meta_data"

```
data "template_file" "meta_data" {
  template = file("${path.module}/network_interfaces.cfg")
}
```

Rq : https://cloudinit.readthedocs.io/en/latest/topics/datasources/nocloud.html#datasource-nocloud

------------------------------------------------------------------------------------

# KVM : IP static via Cloud-Init


<br>


* ajout à notre cloudinit_disk

```
resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  user_data = data.template_file.user_data.rendered
  meta_data  = data.template_file.meta_data.rendered
}
```

<br>


* libvirt_interface avec un network_interface reprenant le nom uniquement

```
  network_interface {
    network_name = libvirt_network.vm_network.id
  }
```

* fichier network_interfaces.cfg

```
network-interfaces: |
  auto eth0
  iface eth0 inet static
  address 10.0.1.2
  network 10.0.1.0
  netmask 255.255.255.0
  broadcast 10.0.1.255
  gateway 10.0.1.1
  dns-nameservers 8.8.8.8
bootcmd:
  - ifdown eth0
  - ifup eth0
```
