%title: Terraform
%author: xavki


# Terraform : docker registry et image


<br>


Doc : https://www.terraform.io/docs/providers/docker/d/registry_image.html

<br>


* checker l'idempotence >> vidéo précédente = problème

```
terraform plan
```

<br>


* important bien checker les contenus des attributs

```
terraform show
```

<br>


* connexion à une registry

```
data "docker_registry_image" "myimg" {
  name = "priximmo/testter:1.0"
}
```

<br>


* pull d'une image

```
resource "docker_image" "testter" {
  name          = data.docker_registry_image.myimg.name
  pull_triggers = [ data.docker_registry_image.myimg.sha256_digest ]
}
```

Rq : importance du trigger

<br>


* utilisation de l'attribut "latest" et pas du "name"
