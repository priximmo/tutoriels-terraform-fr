provider "docker" {
  host = "ssh://${var.ssh_user}@${var.ssh_host}:22"
}

data "docker_registry_image" "dockerhub" {
  name = "priximmo/terdock:1.0"
}

resource "docker_image" "terdock" {
  name          = data.docker_registry_image.dockerhub.name
  pull_triggers = [ data.docker_registry_image.dockerhub.sha256_digest ]
}


