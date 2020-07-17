
resource "kubernetes_service" "wp-svc-mysql" {
  metadata {
    name = "wp-mysql"
  }
  spec {
    selector = {
      app = var.mysql-lbl
    }
    port {
      port = var.mysql-port
    }
    cluster_ip = "None"
  }
}


resource "kubernetes_service" "wp-svc-wordpress" {
  metadata {
    name = "wp-svc-wordpress"
  }
  spec {
    selector = {
      app = var.wordpress-lbl
    }
    port {
      port = var.wordpress-port
    }
    cluster_ip = "None"
  }
}

