
module "pvpvc_mysql" {
  source    	= "./modules/pvpvc"
  pvpvc-dir  	= var.mysql-dir
  pvpvc-name 	= "mysql"
  pvpvc-size	= "2Gi"
}

module "pvpvc_wordpress" {
  source  	= "./modules/pvpvc"
  pvpvc-dir  	= var.wordpress-dir
  pvpvc-name	= "wordpress"
  pvpvc-size	= "2Gi"
}

