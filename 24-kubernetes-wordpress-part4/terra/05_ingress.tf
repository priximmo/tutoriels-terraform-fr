resource "kubernetes_ingress" "wp-ingress" {
  metadata {
    name = "wordpress-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }
  spec {
    rule {
      host = var.wordpress-host
      http {
        path {
          backend {
            service_name = kubernetes_service.wp-svc-wordpress.metadata[0].name
            service_port = var.wordpress-port
          }
          path = "/"
        }
      }
    }
  }
}

