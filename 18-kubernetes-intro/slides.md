%title: Terraform
%author: xavki


# Terraform : Kubernetes


<br>
* prérequis : cluster kubernetes
		* port accessible 6443
		* certificat kube_config

* terraform > kube-apiserver

<br>
* installer terraform sur une machine qui peut accéder au cluster

```
sudo yum install -y wget unzip
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
sudo unzip terraform_0.12.24_linux_amd64.zip  -d /usr/bin/
sudo chmod 755 /usr/bin/terraform
```

----------------------------------------------------------------------------

# Terraform : Kubernetes


<br>
DATA SOURCES : sources d'informations 

<br>
* kubernetes_all_namespaces : liste de tous les NS

<br>
* kubernetes_config_map : accès aux configmap

<br>
* kubernetes_ingress : liste des ingress

<br>
* kubernetes_namespace : information sur un namespace

<br>
* kubernetes_secret : liste des secrets (configmaps like)

<br>
* kubernetes_service_account : compte de service utilisé dans les pods

<br>
* kubernetes_service : liste des informations sur un service

<br>
* kubernetes_storage_class : informations relatives aux classes de stockages (association PV ET PVC)


----------------------------------------------------------------------------

# Terraform : Kubernetes


<br>
RESOURCES : création d'objets

<br>
* kubernetes_pod

<br>
* kubernetes_deployment 

<br>
* kubernetes_stateful_set

<br>
* kubernetes_namespace

<br>
* kubernetes_replication_controller

<br>
* kubernetes_service

<br>
* kubernetes_config_map

<br>
* kubernetes_secret
