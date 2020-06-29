%title: Terraform
%author: xavki


# Terraform : installation


<br>

Page de download : https://www.terraform.io/downloads.html

```
sudo yum install -y wget unzip
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
sudo unzip terraform_0.12.24_linux_amd64.zip  -d /usr/local/bin/
sudo chmod 755 /usr/local/bin/terraform
```

<br>
* créer unr répertoire de projet

```
mkdir monprojet && cd monprojet
```

* iniialisation du projet

```
terraform init
```

<br>
* test du hello world

```
cat main.tf
output "text" {
 value = "hello world"
}
```

