%title: Terraform
%author: xavki


# Workspaces & Locals


<br>


* workspace = isolation

* via les tfstate > plusieurs state
		* ./terraform.state.d/xxx

* exemple : un workspace par env

<br>


* commandes

```
terraform workspace new prod
terraform workspace list
terraform workspace select dev
```

<br>


* locals = capacité à affecter un nom à une expression

* variable à contenu dynamique

---------------------------------------------------------------------

# Workspaces & Locals


<br>


* définition de l'environnement

```
env="${terraform.workspace}"
```

<br>


* préparation de notre local à plusieurs env

```
  net = {
    dev = "10.0.2"
    prod = "10.0.1"
  }
```

<br>


* définition en fonction de l'environnement

```
ip = "${lookup(local.net,local.env)}.2"

  name = "mycentos_${terraform.workspace}"
  type = "dir"
  path = "/disklv/images/${terraform.workspace}"

  name = "vm_network_${terraform.workspace}"
  addresses = ["${lookup(local.net,local.env)}.0/24"]


name      = "${local.instance1.name}-${local.env}"
```
