output "summary" {
  value = {
     mysql-img          = kubernetes_deployment.wp-dep-mysql.spec[0].template[0].spec[0].container[0].image
     mysql-dir		= module.pvpvc_mysql.pvpvc-dir
     wordpress-img      = kubernetes_deployment.wp-dep-wordpress.spec[0].template[0].spec[0].container[0].image
     wordpress-dir	= module.pvpvc_wordpress.pvpvc-dir
     url                = kubernetes_ingress.wp-ingress.spec[0].rule[0].host
  }
}

