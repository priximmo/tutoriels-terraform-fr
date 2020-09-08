resource "libvirt_volume" "centos7-qcow2" {
  name = "centos7-${var.name}.qcow2"  
  source = "./CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
  pool = var.pool
}

