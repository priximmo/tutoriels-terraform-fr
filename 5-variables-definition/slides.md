%title: Terraform
%author: xavki


# Terraform : Stockage des variables


<br>


* type de variables :
		* string
		* number
		* bool (boolean)
		* liste
		* map

```
variable "mybool" {
    type = "bool"
    default = true
}
```

<br>


* deux manières d'utiliser

```
output "mavariable" {
  value = var.str
}
output "mavariable" {
  value = "${var.str}"
}

```

-----------------------------------------------------------------------------

# Terraform : Stockage des variables


<br>


* définition à plusieurs niveaux : environnement > fichier spécifique

<br>


* ordre des variables
	* 1 - environnement
	* 2 - fichier : terraform.tfvars
	* 3 - fichier json : terraform.tfvars.json
	* 4 - fichier \*.auto.tfvars ou \*.auto.tfvars.json
	* 5 - CLI : -var ou - var-file 

<br>


* environnement:

```
export TF_VAR_str="env"
terraform apply
```

<br>


* fichier terraform.tfvars

```
echo 'str="terraform"'> terraform.tfvars
```

<br>


* fichier auto

```
echo 'str="auto"'> production.auto.tfvars
```

<br>


* le fichier ou la cli

```
terraform apply -var "str=cli"
```

```
terraform apply -var-file vafile.tfvars -var "str=cli"
```
