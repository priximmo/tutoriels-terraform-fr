%title: Terraform
%author: xavki


# Terraform : modules - introduction


<br>


* utilisation d'un module

```
module "monmodule" {
  source = "./rep_module"
}
```
* structure d'un module 

```
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
```

