%title: Terraform
%author: xavki


# KVM : installation provider et première VM


<br>
* prérequis : installation terraform

```
sudo apt install -y wget unzip
wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
sudo unzip terraform_0.12.24_linux_amd64.zip  -d /usr/local/bin/
 sudo chmod 755 /usr/local/bin/terraform
```

<br>
* installation du provider

```
mkdir ~/monprojet && cd ~/monprojet
terraform init
mkdir ~/.terraform.d/plugins && cd ~/.terraform.d/plugins
wget https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.6.2/terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz
tar xvf terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz
rm terraform-provider-libvirt-0.6.2+git.1585292411.8cbe9ad0.Ubuntu_18.04.amd64.tar.gz

mkdir ~/monprojet && cd ~/monprojet
terraform init
```

<br>
* modification des permissions kvm

```
sudo usermod -aG kvm,libvirt $USER
sudo echo 'security_driver = [ "none" ]'> /etc/libvirt/qemu.conf
sudo systemctl restart libvirtd
```

-----------------------------------------------------------------------------------------

# KVM : installation provier et première VM


<br>
* première VM

```
provider "libvirt" {
  uri = "qemu:///system"
}
resource "libvirt_volume" "centos7-qcow2" {
  name = "centos7.qcow2"
  pool = "default"
  source = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}
resource "libvirt_domain" "myvm" {
  name   = "myvm"
  memory = "1024"
  vcpu   = 1
  network_interface {
    network_name = "default"
  }
  disk {
    volume_id = libvirt_volume.centos7-qcow2.id
  }
  console {
    type = "pty"
    target_type = "serial"
    target_port = "0"
  }
  graphics {
    type = "spice"
    listen_type = "address"
    autoport = true
  }
}
output "ip" {
  value = "${libvirt_domain.myvm.network_interface.0.addresses.0}"
}
```

```
virsh list --all
virsh net-dhcp-leases default
```
