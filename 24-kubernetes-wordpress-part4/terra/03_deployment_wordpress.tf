resource "kubernetes_deployment" "wp-dep-wordpress" {
  metadata {
    name = "wp-dep-wordpress"
    labels = {
      app = var.wordpress-lbl
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.wordpress-lbl
      }
    }

    template {
      metadata {
        labels = {
          app = var.wordpress-lbl
        }
      }

      spec {
        container {
          image = var.wordpress-img
          name  = "wordpress"
          env {
            name = "WORDPRESS_DB_HOST"
            value = "wp-mysql"
          }

          env {
            name = "WORDPRESS_DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.mysql.metadata[0].name
                key = "password"
              }
            }
          }
          port {
            container_port = var.wordpress-port
            name = "wordpress"
          }
          volume_mount {
            name = "wordpress-persistent-storage"
            mount_path = "/var/www/html"
          }
        }
        volume {
          name = "wordpress-persistent-storage"
          persistent_volume_claim {
            claim_name = kubernetes_persistent_volume_claim.wp-pvc-wordpress.metadata[0].name
          }
        }
      }
    }
  }
}

