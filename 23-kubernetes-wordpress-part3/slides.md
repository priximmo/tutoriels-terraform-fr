%title: Terraform
%author: xavki


# Terraform : Kubernetes - Wordpress


<br>


* étapes :
		* installation des volumes : PV et PVC
		* installation des deployments
		* installation des services
		* installation de l'ingress


<br>


INSTALLATION DES DEPLOYMENTS

* organisation :
		* wordpress + service
		* ingress + output + organsation (prochaine vidéo)

* deployment ~ template de pods + replicaset

-------------------------------------------------------------------------

# Terraform : Kubernetes - Wordpress


<br>


* variables :

main.tf
```
variable "wordpress-port" {}
variable "wordpress-img" {}
variable "wordpress-host" {}
variable "wordpress-lbl" {}
```

terraform.tfvars
```
wordpress-port  = 80
wordpress-img = "wordpress:latest"
wordpress-host = "wordpress.kub"
wordpress-dir = "/wp/wordpress"
wordpress-lbl = "wp-wordpress"
```

<br>


deployment cf fichier

<br>


* service

```
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
    type = "NodePort"
  }
}
```
