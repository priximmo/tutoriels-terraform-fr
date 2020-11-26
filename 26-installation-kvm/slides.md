%title: Terraform
%author: xavki


# KVM : Installation


<br>


* check de compatibilité

```
grep -E -c "vmx|svm" /proc/cpuinfo
sudo apt install -y cpu-checker
kvm-ok
```

<br>


* installation

```
sudo apt install -y qemu qemu-kvm libvirt-daemon bridge-utils virt-manager virtinst
```

* check module kernel

```
lsmod | grep -i kvm
```

<br>


* start libvirtd

```
sudo systemctl start libvirtd
sudo systemctl enable libvirtd --now
```

----------------------------------------------------------------------------------------------------

# KVM : Installation

<br>


* si pas de default

```
sudo virsh net-list --all
sudo virsh net-define --file default.xml
```


cat default.xml

```
<network>
  <name>default</name>
  <uuid>9a05da11-e96b-47f3-8253-a3a482e445f5</uuid>
  <forward mode='nat'/>
  <bridge name='virbr0' stp='on' delay='0'/>
  <mac address='52:54:00:0a:cd:21'/>
  <ip address='192.168.122.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.122.2' end='192.168.122.254'/>
    </dhcp>
  </ip>
</network>
```

<br>


* si default pas activé

```
sudo virsh net-list --all
sudo virsh net-start default
sudo  virsh net-list --all
sudo virsh net-autostart --network default
```


----------------------------------------------------------------------------------------------------

# KVM : Installation


<br>


* si nécessaire

```
sudo systemctl start systemd-networkd
sudo systemctl enable systemd-networkd
```

sudo systemctl start systemd-networkd

sudo systemctl start systemd-networkd


wget https://releases.ubuntu.com/20.04/ubuntu-20.04-desktop-amd64.iso
