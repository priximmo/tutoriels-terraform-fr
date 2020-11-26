%title: Terraform
%author: xavki


# Terraform : docker provider


<br>


* mise en place de la socket si à distance

* faille de sécurité

<br>


* activation de la socket docker

```
cat /etc/systemd/system/docker.service.d/startup_options.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H tcp://192.168.21.103:2375 -H unix:///var/run/docker.sock
```

```
sudo systemctl daemon-reload
sudo systemctl restart docker
```

<br>


* test

```
docker -H 192.168.21.103:2375 ps -a
```

-----------------------------------------------------------

# Terraform : docker provider


<br>


* déclaration du provider

```
provider "docker" {
  host = "tcp://192.168.21.103:2375"
}
```

Rq : possible par la socket unix

<br>


* télécharger une image

```
resource "docker_image" "nginx" {
  name = "nginx:latest"
}
```

<br>


* lancement du conteneur

```
resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "enginecks"
  ports {
    internal = 80
    external = 80
  }
}
```
