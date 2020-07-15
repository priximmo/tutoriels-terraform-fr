provider "kubernetes" {
  load_config_file = true
}

resource "kubernetes_pod" "nginx" {

  metadata {
    name = "nginx-example"
    labels = {
      App = "nginx"
    }
  }

  spec {
    container {
      image = "nginx:latest"
      name  = "mynginx"
      port {
        container_port = 80
      }
    }
  }

}
