%title: Terraform
%author: xavki


# KVM : Pool de Stockage


<br>


* pool storage = espace dédié au stockage des disques des VM 

Documentation : https://libvirt.org/storage.html

<br>


* libvirt au lancement monte les volumes en question

<br>


* description au format xml (comme les VM ou le réseau)

* cf GUI

<br>


* exemple source

```
  <source>
    <host name='localhost'/>
    <dir path='/var/lib/libvirt/images'/>
    <format type='nfs'/>
    <protocol ver='3'/>
  </source>
```

<br>


* exemple destination

```
  <target>
    <path>/dev/disk/by-path</path>
    <permissions>
      <owner>107</owner>
      <group>107</group>
      <mode>0744</mode>
      <label>virt_image_t</label>
    </permissions>
  </target>
```

--------------------------------------------------------------------------------------------------------

# KVM : Pool de Stockage

* commandes

```
virsh pool-list --all
virsh pool-define-as guest_images dir - - - - "/guest_images"
virsh pool-build <nom_pool>
virsh pool-start <nom_pool>
virsh pool-destroy <nom_pool>
virsh pool-undefine <nom_pool>
```


--------------------------------------------------------------------------------------------------------

# KVM : Pool de Stockage



<br>


* création du pool

```
resource "libvirt_pool" "pool_mycentos" {
 name = "mycentos"
 type = "dir"
 path = "/disklv/images/"
}
```

<br>


* utilisation du pool > volumes

```
resource "libvirt_volume" "centos7-qcow2" {
  name = "centos7-${var.name}.qcow2"
  pool = <pool_name>
  source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}
```

<br>


Attention : idem pour le volume cloudinit

```
resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit-${var.name}.iso"
  pool = var.pool
  user_data = data.template_file.user_data.rendered
  meta_data = data.template_file.meta_data.rendered
}
```

--------------------------------------------------------------------------------------------------------

# KVM : Pool de Stockage

<br>


* utilisation via le module en passant la variable name

```
module "instance1" {
  source    = "./modules/instances"
  ip        = var.instance1.ip
  network   = libvirt_network.vm_network.name
  name      = var.instance1.name
  pool      = libvirt_pool.pool_mycentos.name
}
```
