%title: Terraform
%author: xavki


# Locals & Lookup


<br>
* locals = capacité à affecter un nom à une expression

<br>
Documentation : https://www.terraform.io/docs/configuration/locals.html

```
locals {
  net = {
    default = "10.0.2"
  }
}
```

<br>
* variable à contenu dynamique

```
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
```

Rq: lookup > fonction > parcourir une map et récupérer une clef

<br>
* les isoler comme les variables

-------------------------------------------------------------------------------------


# Locals & Lookup



<br>
* utilisation

```
resource "libvirt_network" "vm_network" {
  name = "vm_network_${terraform.workspace}"
  addresses = ["${lookup(local.net,"default")}.0/24"]
  mode = "nat"
  dhcp {
   enabled = false
  }
}
```

<br>
* ou encore 

```
module "instance1" {
  source    = "./modules/instances"
  ip        = local.instance1.ip
  network   = libvirt_network.vm_network.name
  name      = "${local.instance1.name}-default"
  pool      = libvirt_pool.pool_mycentos.name
}
```



