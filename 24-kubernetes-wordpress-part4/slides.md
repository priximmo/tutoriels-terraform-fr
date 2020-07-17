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
		* ingress + output + organisation
		* modules

* ingress

url > haproxy > ingress controller > ingress > service > pods

-------------------------------------------------------------------------

# Terraform : Kubernetes - Wordpress

<br>
* service wordpress 

```
cluster_ip = "None"
``` 

<br>
* ingress

```
resource "kubernetes_ingress" "wp-ingress" {
  metadata {
    name = "wordpress-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    }
  }

  spec {
    rule {
      host = var.wordpress-host
      http {
        path {
          backend {
            service_name = kubernetes_service.wp-svc-wordpress.metadata[0].name
            service_port = var.wordpress-port
          }
          path = "/"
        }
      }
    }
  }
}
```

-------------------------------------------------------------------------

# Terraform : Kubernetes - Wordpress

<br>

```
output "summary" {
  value = {
    mysql-img           = kubernetes_deployment.wp-dep-mysql.spec[0].template[0].spec[0].container[0].image
    mysql-vol           = kubernetes_persistent_volume.wp-pv-mysql.spec[0].persistent_volume_source[0].host_path[0].path
    wordpress-img       = kubernetes_deployment.wp-dep-wordpress.spec[0].template[0].spec[0].container[0].image
    wordpress-vol       = kubernetes_persistent_volume.wp-pv-wordpress.spec[0].persistent_volume_source[0].host_path[0].path
    url                 = kubernetes_ingress.wp-ingress.spec[0].rule[0].host
  }
}
```
