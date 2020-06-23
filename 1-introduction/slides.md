%title: Terraform
%author: xavki


# Terraform : introduction


<br>
* C'est quoi ? management d'infrastructure
		* construire 
		* modifier
		* versionner

* site : https://www.terraform.io/ | Hashicorp

<br>
* utilisable sur de nombreux providers :
	https://www.terraform.io/docs/providers/index.html

* providers de différents types : cloud, software, réseau, database...

* action sur infrastructure > fichiers de configurations (HCL)

* génération d'un plan d'application > application du plan (état final recherché)

<br>
* utilisation :
		* IaC (infrastructure as code)
		* automatisation d'infrastructure
		* maintien d'infrastructure
		* CI/CD

----------------------------------------------------------------------

# Terraform : introduction


<br>
* State :
		* stockage de l'état (State) de l'infra et sa configuration
		* diff entre l'état réel et le state // metadata // objectif de perfs sur de large infra
		* state = terraform.tfstate
		* tfstate >> plan >> changements/créations

<br>
* différentes étapes :
		* refresh
		* plan
		* apply
		* destroy

```
    apply              Builds or changes infrastructure
    destroy            Destroy Terraform-managed infrastructure
    import             Import existing infrastructure into Terraform
    init               Initialize a Terraform working directory
    plan               Generate and show an execution plan
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    validate           Validates the Terraform files
```


----------------------------------------------------------------------

# Terraform : introduction


<br>
* fichiers utilisés = .tf

* resources = une brique d'infra (instances, containers, switch...)
		* cycle de vie : création/lecture/modif/suppression
* utilisation par l'API des providers

* Iaas PaaS SaaS

