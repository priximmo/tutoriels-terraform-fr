provider "docker" {
  host = "tcp://${var.ssh_host}:2375"
}

data "docker_registry_image" "myimg" {
  name = "priximmo/testter:1.0"
}

resource "docker_image" "testter" {
  name          = data.docker_registry_image.myimg.name
  pull_triggers = [ data.docker_registry_image.myimg.sha256_digest ]
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
}
