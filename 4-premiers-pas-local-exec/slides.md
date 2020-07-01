%title: Terraform
%author: xavki


# Terraform : Local-Exec

remote-exec
file
habitat

<br>
* principe de base :
	* provider > resources

Pour apprendre :

* utilisation de provisioner sur ces resources (passer des commandes)
		> provisioner remote-exec : exécution sur la machine distante
		> provisioner local-exec : exécution sur la machine terraform

<br>
* Pour remote-exec et local-exec :
	* provider > resource > provisionner
	* aws > aws_instance > local-exec

<br>
```
provider "aws" {
  region = "eu-west-3"
}
resource "aws_instance" "server_web" {
  ...
  provisioner "local-exec" {
    command = "echo ${aws_instance.web.private_ip} >> private_ips.txt"
  }
}
```

----------------------------------------------------------------------------

# Terraform : Local-Exec


<br>
* si on a pas de resource (pas de provider par ex.)

* utilisation de null_resource

```
resource "null_resource" "cluster" {
  provisioner "local-exec" {
    command="echo 'Hello Xavki !!!' > /tmp/xavki.txt"
  }
}
```
