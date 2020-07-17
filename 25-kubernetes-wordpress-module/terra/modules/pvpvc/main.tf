resource "kubernetes_persistent_volume" "wp-pv" {
  metadata {
    name = "pv-${var.pvpvc-name}"
  }
  spec {
    capacity = {
      storage = var.pvpvc-size
    }
    access_modes = ["ReadWriteMany"]
    persistent_volume_source {
      host_path {
        path = var.pvpvc-dir
      }
    }
  }
}


resource "kubernetes_persistent_volume_claim" "wp-pvc" {
  metadata {
    name = "pvc-${var.pvpvc-name}"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = var.pvpvc-size
      }
    }
    volume_name = kubernetes_persistent_volume.wp-pv.metadata[0].name 
  }
}
