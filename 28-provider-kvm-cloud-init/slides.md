%title: Terraform
%author: xavki


# KVM : Cloud-Init


<br>
* cloud init : post-installation

* création de users, clef ssh, sécurité ,package, lancement de commandes...

<br>
* amélioration sur la vidéo précédente : pas de download

wget "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2
wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img

```
resource "libvirt_volume" "centos7-qcow2" {
  name = "centos7.qcow2"
  pool = "default"
  source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}
```

* amélioration : attendre l'ip avant de rendre la main pour output

```
  network_interface {
    network_name = "default"
    wait_for_lease = true
  }
```

-----------------------------------------------------------------------------------------

# KVM : Cloud-Init


<br>
* ajout du fichier cloud init à une data source

```
data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}
```

<br>
* définition d'un disk dédié

```
resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  user_data = data.template_file.user_data.rendered
}
```

<br>
* ajout du cloud init dans la défintion de la VM

```
  cloudinit = libvirt_cloudinit_disk.commoninit.id
```

-----------------------------------------------------------------------------------------

# KVM : Cloud-Init


mkpasswd --method=SHA-512

```
#cloud-config
hostname: xavkiland
fqdn: xavki.land
users:
  - name: xavki
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    home: /home/xavki
    shell: /bin/bash
    lock_passwd: false
    ssh-authorized-keys:
      - ssh-rsa AAAAB.....
ssh_pwauth: true
chpasswd:
  list: |
     xavki: $6$K3wm2QGL61.$XEwSHL8OT3K2NEaSIIPuur4BIVzuRaVGtFBncOgHSK63Ozry0b7dj1RDZuiBP7k7heJjRmLsJU3CpEaXOuhYB1
  expire: False
packages:
- httpd
- git

runcmd:
  - [ systemctl, enable, httpd ]
  - [ systemctl, start, httpd ]

final_message: "Let's GO !!! after $UPTIME seconds"

```


