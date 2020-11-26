%title: Terraform
%author: xavki


# KVM : IP static via Mac Address


<br>


* mac address = adresse physique unique d'une interface réseau

<br>


* impossible de fixer l'ip directement dans la ressource "libvirt_domain"

<br>


* fixer la mac address :

```
  network_interface {
    network_name = "xavki"
    mac = "52:54:00:62:B1:22"
  }
```

<br>


* définition des ip par mac address dans la conf réseau

<br>


* exemple du dump xml du réseau default

```
virsh net-list
virsh net-dumpxml default
```

------------------------------------------------------------------------------

# KVM : IP static via Mac Address


<br>


* créer son propre

```
<network>
  <name>xavki</name>
  <forward mode='nat'>
    <nat>
      <port start='1024' end='65535'/>
    </nat>
  </forward>
  <bridge name='virbr1' stp='on' delay='0'/>
  <mac address='52:54:00:0a:cd:22'/>
  <ip address='192.168.123.1' netmask='255.255.255.0'>
    <dhcp>
      <range start='192.168.123.2' end='192.168.123.254'/>
      <host mac='52:54:00:62:B1:22' name='myvm' ip='192.168.123.2'/>
    </dhcp>
  </ip>
  <dns enable='yes' />
</network>
```

virsh net-define net-xavki.xml
virsh net-start xavki
virsh net-autostart xavki
virsh net-stop xavki
virsh net-undefine xavki

virsh net-edit xavki

virsh net-update xavki add ip-dhcp-host "<host mac='52:54:00:62:b1:23' name='myvm2' ip='192.168.123.3' />" --live --config

virsh net-update xavki delete ip-dhcp-host "<host mac='52:54:00:62:b1:23' name='myvm2' ip='192.168.123.3' />" --live --config

ls /var/lib/libvirt/dnsmasq/
