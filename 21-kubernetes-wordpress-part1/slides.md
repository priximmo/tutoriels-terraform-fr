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
INSTALLATION DES PV ET PVC

* pv > pvc > deployment > pod

* organisation : hostpath
		* 2 volumes : mysql et wordpress
		* 2 pv
		* 2 pvc
		* 1 secret : mdp mysql

-------------------------------------------------------------------------

# Terraform : Kubernetes - Wordpress



<br>
* déclaration des variables

main.tf
```
variable "mysql-dir" {}
variable "wordpress-dir" {}
variable "mysql-password" {}
```

terraform.tfvars
```		
mysql-dir = "/wp/mysql"
wordpress-dir = "/wp/wordpress"
mysql-password  = "password"
```	

<br>
* provider

```
provider "kubernetes" {
  load_config_file = true
}
```

-------------------------------------------------------------------------

# Terraform : Kubernetes - Wordpress


<br>
* persistent volume mysql

```
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
```


-------------------------------------------------------------------------

# Terraform : Kubernetes - Wordpress


<br>
* persistent volume wordpress

```
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
```


-------------------------------------------------------------------------

# Terraform : Kubernetes - Wordpress


<br>
* persistent volume claim mysql

```
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
```


-------------------------------------------------------------------------

# Terraform : Kubernetes - Wordpress


<br>
* persistent volume claim wordpress

```
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
```


-------------------------------------------------------------------------

# Terraform : Kubernetes - Wordpress


<br>
* création d'un secret = mot de passe bdd

```
resource "kubernetes_secret" "mysql" {
  metadata {
    name = "mysql-pass"
  }
  data = {
    password = var.mysql-password
  }
}
```
