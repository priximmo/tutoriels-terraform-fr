%title: Terraform
%author: xavki


# Terraform : Notions et Définitions


<br>
* terraform = GO
https://www.terraform.io/docs/providers/index.html


<br>
* provider : fournisseur de ressources par API (principalement)
Registry des providers : https://registry.terraform.io/
Certains intégrés dans le binaire GO

```
provider "kubernetes" {
  version = "~> 1.10"
}
```

-------------------------------------------------------------------------

# Terraform : Notions et Définitions


<br>
* resource : élément qui peut être CRUD via le provider 
		* Create, Remove, Update, Delete
		* un objet d'une ressource est unique (1 nom) dans un même module

```
resource "ressource_type" "ressource_nom" {
  arg = "valeur"
}
```

exemple :

```
resource "aws_instance" "web" {
  ami = "some-ami-id"
  instance_type = "t2.micro"
}
```

<br>
* data sources : ressource non modifiable

```
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["myami-*"]
  }
}
```



-------------------------------------------------------------------------

# Terraform : Notions et Définitions


<br>
* meta arguments

```
resource "ressource_type" "ressource_nom" {
  count = nb
  arg = "valeur"
}
```

Rq : count = itération

<br>
* le For each

```
variable "instances" {
  type = "map"
  default = {
    clef1 = "123"
    clef2 = "456"
    clef3 = "789"
  }
}
resource "aws_instance" "server" {
  for_each = var.instances 
  ami = each.value
  instance_type = "t2.micro"
  tags = {
    Name = each.key
  }
}
```

-------------------------------------------------------------------------

# Terraform : Notions et Définitions


<br>
* State : stockage de l'état des ressources 

* par défaut terraform.tfstate

* Remote state : 
		* consul
		* s3
		* postgres
		* ...

Attention aux données sensibles

