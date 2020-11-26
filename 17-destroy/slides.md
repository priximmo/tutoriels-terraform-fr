%title: Terraform
%author: xavki


# Terraform : Destroy


<br>


* suppression des ressources gérées par le tfstate

```
terraform destroy
```

<br>


* option -target

```
terraform destroy -target <resource|module>
```

<br>


* when destroy

```
provisioner "local-exec" {
  when = destroy
  command = "echo 'tout cassé'"
}
```
