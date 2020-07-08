%title: Terraform
%author: xavki


# Terraform : docker volume


<br>
Doc volume : https://www.terraform.io/docs/providers/docker/r/volume.html
Doc container : https://www.terraform.io/docs/providers/docker/r/container.html

<br>
* création d'un volume

```
resource "docker_volume" "xavkivol" {
  name = "myvol"
}
```

<br>
* utilisation du volume dans la ressource conteneur

```
  volumes {
    container_path = "/usr/share/nginx/html/"
    volume_name = docker_volume.xavkivol.name
  }
```

-------------------------------------------------------------------

# Terraform : docker volume


<br>
* plus complet

```
resource "null_resource" "ssh_target" {
  connection {
    type        = "ssh"
    user        = var.ssh_user
    host        = var.ssh_host
    private_key = file(var.ssh_key)
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p /srv/data/",
      "sudo chmod 777 -R /srv/data/",
      "sleep 5s"
    ]
  }
}
resource "docker_volume" "xavkivol" {
  name = "myvol"
  driver = "local"
  driver_opts = {
    o = "bind"
    type = "none"
    device = "/srv/data/"
  }
  depends_on = [ null_resource.ssh_target ]
}
```
