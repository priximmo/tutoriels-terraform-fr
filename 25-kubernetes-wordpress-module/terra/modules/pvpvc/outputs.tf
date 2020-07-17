output "pvpvc-name" {
  value = kubernetes_persistent_volume_claim.wp-pvc.metadata[0].name
}
output "pvpvc-dir" {
  value = kubernetes_persistent_volume.wp-pv.spec[0].persistent_volume_source[0].host_path[0].path
}
