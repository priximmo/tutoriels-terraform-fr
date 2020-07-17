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
		* mysql > service
		* wordpress (prochaine vidéo)

* deployment ~ template de pods + replicaset

-------------------------------------------------------------------------

# Terraform : Kubernetes - Wordpress


<br>
* variables :

main.tf
```
variable "mysql-img" {}
variable "mysql-lbl" {}
```

terraform.tfvars
```
mysql-img = "mysql:5.6"
mysql-lbl = "wp-mysql"
```

<br>
deployment cf fichier

<br>
* service

```
resource "kubernetes_service" "wp-svc-mysql" {
  metadata {
    name = "wp-mysql"
  }
  spec {
    selector = {
      app = var.mysql-lbl
    }
    port {
      port = 3306
    }
    cluster_ip = "None"
  }
}
```
