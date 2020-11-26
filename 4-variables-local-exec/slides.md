%title: Terraform
%author: xavki


# Terraform : Variables et Local-Exec


<br>


* utilisation de provisioner sur ces resources (passer des commandes)
		> provisioner remote-exec : exécution sur la machine distante
		> provisioner local-exec : exécution sur la machine terraform

<br>


* type de variables :
		* string
		* list
		* map

<br>


* exemple string :

```
variable "str" {
  type = string
  default = "127.0.0.1 gitlab.test"
}
resource "null_resource" "node1" {
 provisioner "local-exec" {
  command = "echo '${var.str}' > hosts.txt"
 }
}
```

----------------------------------------------------------------------------

# Terraform : Variables et Local-Exec



<br>


* map

```
variable "hosts" {
  default     = {
    "127.0.0.1" = "localhost gitlab.local"
    "192.169.1.168" = "gitlab.test"
    "192.169.1.170" = "prometheus.test"
  }
}
resource "null_resource" "hosts" {
 for_each = var.hosts
 provisioner "local-exec" {
  command = "echo '${each.key} ${each.value}' >> hosts.txt"
 }
}
```

<br>


* trigger

```
resource "null_resource" "hosts" {
 for_each = var.hosts
 triggers = {
   foo = each.value
 }
...
```


Rq : boucle for préférable

----------------------------------------------------------------------------

# Terraform : Variables et Local-Exec



<br>


* parcourir une liste

```
variable "hosts" {
  default     = ["127.0.0.1 localhost","192.168.1.133 gitlab.test"]
}
resource "null_resource" "hosts" {
 count = "${length(var.hosts)}"
 provisioner "local-exec" {
  command = "echo '${element(var.hosts, count.index)}' >> hosts.txt"
 }
}
```

<br>


* avec le trigger

```
variable "hosts" {
  default     = ["11","2","3"]
}
resource "null_resource" "hosts" {
 count = "${length(var.hosts)}"
 triggers = {
   foo = element(var.hosts, count.index)
 }
 provisioner "local-exec" {
  command = "echo '${element(var.hosts, count.index)}' >> hosts.txt"
 }
}
```
