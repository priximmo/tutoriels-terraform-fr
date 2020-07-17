resource "kubernetes_persistent_volume" "wp-pv-mysql" {
  metadata {
    name = "pv-mysql"
  }
  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      host_path {
        path = var.mysql-dir
      }
    }
  }
}

resource "kubernetes_persistent_volume" "wp-pv-wordpress" {
  metadata {
    name = "pv-wordpress"
  }
  spec {
    capacity = {
      storage = "2Gi"
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      host_path {
        path = var.wordpress-dir
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "wp-pvc-mysql" {
  metadata {
    name = "pvc-mysql"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "2Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.wp-pv-mysql.metadata[0].name 
  }
}

resource "kubernetes_persistent_volume_claim" "wp-pvc-wordpress" {          
  metadata {
    name = "pvc-wordpress"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "2Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.wp-pv-wordpress.metadata[0].name
  }
}
