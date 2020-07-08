%title: Terraform
%author: xavki


# Terraform : modules - introduction


<br>
* problem de null_resource > impossible de gérer la dépendance


<br>
* utilisation de l'option target

```
terraform apply -target=module.docker
terraform apply -target=module.postgres
```

