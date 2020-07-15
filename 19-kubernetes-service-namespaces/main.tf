provider "kubernetes" {
  load_config_file = true
}

resource "kubernetes_namespace" "xavki" {
  metadata {
    name = "xavki"  
    labels = {
      env = "prod"
    }
  }
}

resource "kubernetes_pod" "monpremierpod" {
  metadata {
    name = "webserver"
    labels = {
      App = "nginx"
    }
    namespace = kubernetes_namespace.xavki.metadata.0.name
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


resource "kubernetes_service" "monpremierservice" {
  metadata {
    name = "webserver-service"
    namespace = kubernetes_namespace.xavki.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_pod.monpremierpod.metadata[0].labels.App
    }
    port {
      port        = 80
    }

    type = "NodePort"
  }
}

output "ns" {
  value = kubernetes_namespace.xavki.metadata[0].name
}
output "app" {
  value = {
    name 	= kubernetes_pod.monpremierpod.metadata[0].name
    container 	= kubernetes_pod.monpremierpod.spec[0].container[0].name
    service 	= kubernetes_service.monpremierservice.spec[0].port[0].node_port
  }
}
