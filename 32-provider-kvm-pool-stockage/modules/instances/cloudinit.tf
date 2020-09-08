data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "meta_data" {
  template = file("${path.module}/network_interfaces.cfg")
  vars = {
    ip = var.ip
  }
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit-${var.name}.iso"
  pool = var.pool
  user_data = data.template_file.user_data.rendered
  meta_data = data.template_file.meta_data.rendered
}
