%title: Terraform
%author: xavki


# Terraform : docker ssh et triggers


<br>
* docker via ssh

```
provider "docker" {
  host = "ssh://${var.ssh_user}@${var.ssh_host}:22"
}
```


<br>
* astuce


```
  triggers = {
    force = timestamp()
  }
```
