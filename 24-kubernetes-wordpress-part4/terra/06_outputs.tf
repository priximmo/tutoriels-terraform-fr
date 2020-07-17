output "summary" {
  value = {
     mysql-img           = kubernetes_deployment.wp-dep-mysql.spec[0].template[0].spec[0].container[0].image
     mysql-vol           = kubernetes_persistent_volume.wp-pv-mysql.spec[0].persistent_volume_source[0].host_path[0].path
     wordpress-img       = kubernetes_deployment.wp-dep-wordpress.spec[0].template[0].spec[0].container[0].image
     wordpress-vol       = kubernetes_persistent_volume.wp-pv-wordpress.spec[0].persistent_volume_source[0].host_path[0].path
     url                 = kubernetes_ingress.wp-ingress.spec[0].rule[0].host
  }
}

