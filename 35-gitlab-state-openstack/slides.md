%title: Terraform
%author: xavki


████████╗███████╗██████╗ ██████╗  █████╗ ███████╗ ██████╗ ██████╗ ███╗   ███╗
╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔═══██╗██╔══██╗████╗ ████║
   ██║   █████╗  ██████╔╝██████╔╝███████║█████╗  ██║   ██║██████╔╝██╔████╔██║
   ██║   ██╔══╝  ██╔══██╗██╔══██╗██╔══██║██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║
   ██║   ███████╗██║  ██║██║  ██║██║  ██║██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║
   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝



-----------------------------------------------------------------------                                                    

# Terraform : Gitlab State & Openstack

<br>

https://docs.gitlab.com/ee/user/infrastructure/iac/terraform_state.html

Fichier de variables d'env (le mieux openrc.sh) :

```
export TF_HTTP_USERNAME="" #user gitlab
export TF_HTTP_PASSWORD="" #token du user gitlab
export OS_USERNAME="" # username du user cloud OS
export OS_PASSWORD="" # password du user
export OS_PROJECT_NAME="" #nom du projet OS
export OS_PROJECT_ID="" #id du projet
export OS_AUTH_URL="" #url du gestionnaire d'identité OS
export OS_REGION_NAME="" #région
export OS_USER_DOMAIN_NAME="" 
export OS_PROJECT_DOMAIN_ID="" #id du projet default)
```

-----------------------------------------------------------------------                                                    

# Terraform : Gitlab State & Openstack

<br>

* soit passer par la commande fournie par gitlab et la compléter

* soit dans le fichier TF

```
terraform {
	required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.51.1"
    }
  }
  backend "http" {
    address = "https://gitlab.com/api/v4/projects/<id_projet_gitlab>/terraform/state/<nom_du_state>"
    lock_address = "https://gitlab.com/api/v4/projects/<id_projet_gitlab>/terraform/state/<nom_du_state>/lock"
    unlock_address = "https://gitlab.com/api/v4/projects/<id_projet_gitlab>/terraform/state/<nom_du_state>/lock"
    lock_method = "POST"
    unlock_method = "DELETE"
    retry_wait_min = 5
  }
}
```
