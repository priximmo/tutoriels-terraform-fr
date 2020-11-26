%title: Terraform
%author: xavki


# Terraform : modules - introduction


<br>


* modules : regroupement de fichiers tf avec une cohérence en matière de resources

<br>


* module terraform = rôle ansible

<br>


* registry : https://registry.terraform.io/

<br>


* module = répertoire(s) + fichier(s) tf

----------------------------------------------------------------------------

# Terraform : modules - introduction


<br>


* utilisation d'un module

```
module "monmodule" {
  source = "./rep_module"
}
```

<br>


* principe d'héritage du provider
		* par défaut celui du fichier dans lequel il est appelé
		* prossibilité de préciser le provider

<br>


* possiblité d'instancier plusieurs fois un même module


```
module "instance1" {
  source = "./rep_module"
}
module "instance2" {
  source = "./rep_module"
}
```

----------------------------------------------------------------------------

# Terraform : modules - introduction


<br>


* structure d'un module 

```
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
```

* plus poussé

```
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── ...
├── modules/
│   ├── nestedA/
│   │   ├── README.md
│   │   ├── variables.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   ├── nestedB/
│   ├── .../
├── examples/
│   ├── exampleA/
│   │   ├── main.tf
│   ├── exampleB/
│   ├── .../
```

----------------------------------------------------------------------------

# Terraform : modules - introduction


<br>


* installation d'un module

```
terraform get
terraform init
```

<br>


* peut permettre de gérer la gestion de dépendances

```
terraform apply -target=module.docker
terraform apply -target=module.postgres
```

Rq : ou via les variables

<br>


* problématique de la vidéo précédente

cf pb de dépendance d'installation de docker avant de jouer le provider docker
