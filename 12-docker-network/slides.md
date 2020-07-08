%title: Terraform
%author: xavki


# Terraform : docker network


<br>
Doc network : https://www.terraform.io/docs/providers/docker/r/network.html
Doc container: https://www.terraform.io/docs/providers/docker/r/container.html

<br>
* création d'un réseau

```
resource "docker_network" "xavkinet" {
  name = "mynet"
}
```

<br>
* utilisation

```
resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "enginecks"
  ports {
    internal = 80
    external = 80
  }
  networks_advanced {
    name = docker_network.xavkinet.name
  }
}
```

-----------------------------------------------------------------------------------------------

# Terraform : docker network



<br>
* changement de range

```
resource "docker_network" "xavkinet" {
  name = "mynet2"
  driver = "bridge"
  ipam_config {
    subnet = "177.22.0.0/24"
  }
}
```

Rq: attention à la manière de modifier
