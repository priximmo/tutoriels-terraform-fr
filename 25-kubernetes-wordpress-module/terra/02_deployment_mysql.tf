
resource "kubernetes_deployment" "wp-dep-mysql" {
  metadata {
    name = "wp-dep-mysql"
    labels = {
      app = var.mysql-lbl
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.mysql-lbl
      }
    }

    template {
      metadata {
        labels = {
          app = var.mysql-lbl
        }
      }

      spec {
        container {
          image = var.mysql-img
          name  = "wp-mysql"
          env {
           name = "MYSQL_ROOT_PASSWORD"
           value_from {
             secret_key_ref {
               name = kubernetes_secret.mysql.metadata[0].name
               key = "password"
             }
           }
          }
          port {
            container_port = var.mysql-port
            name = "mysql"
          }
          volume_mount {
            name = "mysql-persistent-storage"
            mount_path = "/var/lib/mysql"
          }
        }
        volume {
          name = "mysql-persistent-storage"
          persistent_volume_claim {
            claim_name = module.pvpvc_mysql.pvpvc-name
          }
        }
      }
    }
  }
}

