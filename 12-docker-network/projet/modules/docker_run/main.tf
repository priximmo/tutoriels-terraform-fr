
provider "docker" {
  host = "tcp://${var.ssh_host}:2375"
}

resource "docker_network" "xavkinet" {
  name = "mynet2"
  driver = "bridge"
  ipam_config {
    subnet = "177.22.0.0/24"
  }
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

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
